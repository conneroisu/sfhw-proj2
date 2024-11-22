#!/usr/bin/python3

import argparse
import pathlib
import sys
import re
import os
import traceback
import glob
import shutil
import datetime
import hashlib
import logging
from mars import Mars
from modelsim import Modelsim
import args
import multiprocessing as mp
from dump_compare import DumpCompare
import config_parser
from pathlib import Path
from updater import Updater
from results import Results
from output_writer import Output_Writer


def main():
    options = parse_args()
    try:
        if os.path.exists('output/test_failures.txt'):
            os.remove('output/test_failures.txt')
        if os.path.exists('output/errors.log'):
            os.remove('output/errors.log')
    except Exception:
        print('Please close all Questasim windos / files that are accessing output or temp directory.')
        exit(1)

    os.makedirs('output',exist_ok=True)

    config, env = config_parser.read_config(options.config)

    # Updater();


    missing_file = check_project_files_exist()
    if missing_file:
        print(f'\nCould not find {missing_file}')
        print('\nprogram is exiting\n')
        exit(1)

    if not Modelsim.is_installed(config, env):
        print('\nModelsim does not seem to be installed in the expected location')
        print('\nProgram is exiting\n')
        exit(1)

    if not check_vhdl_present():
        print('\nOops! It doesn\'t look like you\'ve copied your processor into src')
        return

    warn_tb_checksum()

    ms = Modelsim(config.modelsim, env)

    if not options.nocompile:
        compile_success = ms.compile('internal/ModelSimContainer/work', "internal/ModelSimContainer/vcom.log")
        if not compile_success:
            print("VHDL Compile Failed -- Errors:")
            shutil.copyfile("internal/ModelSimContainer/vcom.log", "output/vcom.log")
            print("-" * 80)
            print_compile_errors("output/vcom.log")
            print("-" * 80)
            print("See output/vcom.log for more information")
            exit(1)
        else:
            print("All VHDL src files compiled successfully")
    else:
        print('Skipping compilation')

    parrallel_run(options.files, options, config, env)

def print_compile_errors(path):
    with open(path, "r") as f:
        for line in f:
            line = line.strip()
            if line.startswith("**"):
                print("\t" + line)

def parrallel_run(asm_paths, options, config, env):
    jobs = options.jobs
    create_sim_containers(jobs)
    ow = Output_Writer(options.summary)

    workers = [SimWorker(i, config, env, options) for i in range(jobs)]

    m = mp.Manager()
    wqueue = m.Queue()
    rqueue = m.Queue()

    for program in asm_paths:
        wqueue.put(program) # Enqueue each program into the work queue

    for worker in workers:
        p = mp.Process(
            target= worker.wait_for_work,
            args= (wqueue,rqueue),
            daemon=True
            )
        p.start()


    with open('output/test_failures.txt', 'w+') as fail_list:
        for i in range(len(asm_paths)):
            next = rqueue.get() # blocking wait on the results queue
            ow.print(next)
            if not next.compare_pass:
                fail_list.write(f'{next.asm_path}\n')

    for i in range(len(workers)):
        wqueue.put(False)

    try: 
        shutil.rmtree('containers')
    except FileNotFoundError: 
        pass


class SimWorker:
    def __init__(self,container_num, config, env, options):
        self.num = container_num
        self.container = Path(f'containers/sim_container_{self.num}')
        self.config = config
        self.env = env
        self.options = options
        self.ms = Modelsim(config.modelsim, env)

    def wait_for_work(self,wqueue,rqueue):
        while True: 
            program = wqueue.get()
            if program == False:
                return # this is our way of knowing to shut down

            sim = self.simulate(program)
            rqueue.put(sim)
            

    def simulate(self,asm_path):
        '''
        Simulates the given program in modelsim and returns the results
        Returns success, fail_type, and compare
        '''

        asm_path = Path(asm_path)

        results = Results(asm_path)

        mars = Mars(self.config.mars_path)
        errors = mars.check_assemble(asm_path)

        if (errors):
            results.mars_compile_errs = errors
            return results # Give up if mars assemble failed


        errors = mars.run_sim(asm_path, self.container / 'mars.trace')

        if (errors):
            results.mars_sim_errs = errors
            return results # Give up if mars simulation failed

        results.mars_pass = True

        mars.generate_hex(asm_path, self.container)
        modelsim_msg = self.ms.sim(self.container, "ms.trace", "vsim.log", timeout=self.options.sim_timeout)
        compare, compare_out, inst, cycles = compare_dumps(self.options, self.container, self.container / "ms.trace", self.container / 'mars.trace')

        inc_num = 1
        inc_str = ""

        while True:
            results.dest_path = f'output/{pathlib.Path(asm_path).name}{inc_str}'

            try: 
                shutil.rmtree(results.dest_path)
                break
            except FileNotFoundError: 
                break
            except:
                print(f'Failed to remove output/{pathlib.Path(asm_path).name}. Is questasim open?')
                inc_str = f'_{inc_num}'
                inc_num += 1
                print(f'Saving instead to "output/{pathlib.Path(asm_path).name}{inc_str}"') 

        shutil.copytree(self.container, results.dest_path, ignore=shutil.ignore_patterns('modelsim_framework.do', 'transcript'))

        results.modelsim_pass = True if not modelsim_msg else False
        results.modelsim_errs = modelsim_msg

        results.compare_pass = compare
        results.compare_errs = compare_out
        results.mars_inst = inst
        results.proc_cycles = cycles


        return results

def create_sim_containers(count):
    ''' Copies compiled work into the containers for a SimWorkerGroup to use '''
    try: 
        shutil.rmtree('containers')
    except FileNotFoundError: 
        pass

    os.mkdir('containers')

    if not os.path.isdir('internal/ModelSimContainer/work'):
        raise Exception('Could not create sim containers since there is no work to copy')

    # copy each container int work
    for i in range(count):
        base = f'containers/sim_container_{i}'
        os.mkdir(base)
        shutil.copytree('internal/ModelSimContainer/work',f'{base}/work',)
        shutil.copyfile('internal/ModelSimContainer/vcom.log',f'{base}/vcom.log',)
        shutil.copyfile('internal/testpy/modelsim_framework.do',f'{base}/modelsim_framework.do')

def check_vhdl_present():
    '''
    Checks if there are any VHDL files present in the src folder other than the provided
    top-level design. prints a warning if there is a file without the .vhd extension

    Returns True if other files exist
    '''
    
    src_dir = glob.glob("proj/src/**/*.vhd", recursive=True)

    expected = {'tb.vhd','mem.vhd','MIPS_Processor.vhd'}

    # return True if at least 1 new .vhd file exists
    is_student_vhd = lambda f: f.endswith('.vhd') and f not in expected
    return any((True for x in src_dir if is_student_vhd(x)))

def parse_args():
    '''
    Parse commnd line arguments into a dictionary, and return that dictionary.

    The returned dictionary has the following keys and types:
    - 'asm-path': str
    - 'max-mismatches': int > 0 
    - 'compile': bool
    '''
   
    if (os.path.exists("internal/version.txt")): 
        with open("internal/version.txt") as f:
            version = f.readlines()[0].strip()
    else:
        version="sp22.0.0"

    parser = argparse.ArgumentParser(fromfile_prefix_chars='@')
    parser.add_argument('--version', action='version', version=version)

    args.set_args(parser)

    opts = parser.parse_args()

    logging.basicConfig(level=opts.debug)

    return opts

def check_project_files_exist():
    '''
    Returns None if all required files exist, otherwise returns path to missing file
    '''
    expected_files = [
        'internal/Mars/MARS_CPRE381.jar',
        'internal/testpy/modelsim_framework.do',
        'internal/testpy/tb.vhd',
    ]
    for path in expected_files:
        if not os.path.isfile(path):
            return path

    return None

def warn_tb_checksum():
    ''' 
    Prints a warning if the testbench has been modified according to a md5 checksum .
    Assumes file exists. Allows both LF and CRLF line endings.
    '''
    expected = {
        b'\x9499\xd6\xbb\xa6\xfb\x8a\x0c\xc9y\x9bm\xaa`\xe0'
        }

    # copy these lines to generate new expected checksums
    with open('internal/testpy/tb.vhd','rb') as f:
        observed = hashlib.md5(f.read()).digest()

    if observed not in expected:
        print('\n** Warning: It looks like src/tb.vhd has been modified. It will be graded using the version from the release **')
        print(f'\n ** Expected: {str(expected)} **')
        print(f'\n ** Observed: {observed} **')


def compare_dumps(options, dir, student_dump, mars_dump):
    '''
    Compares dumps ans prints the results to the console
    '''

    # use user mismatches if the option was specified
    mismatches = options.max_mismatches
    if not mismatches:
        mismatches = 3

    compare_output = [] # accumulator for dump output
    def compare_out_function(compare_line): # accepts each line of compare output and saves it to an array 
        compare_output.append(compare_line)

    dc = DumpCompare(student_dump, mars_dump, mismatches, outfunc=compare_out_function)
    compare_passed = dc.compare()
    cpi = dc.get_cpi()

    try:
        with open(os.path.join(dir, 'compare.txt'),'w') as f:
            f.writelines((f'{x}\n' for x in compare_output)) # map each line to itself + line endings
    except:
        print('** Warning: failed to write comparison file compare.txt **')

    return compare_passed, compare_output, int(dc.inst_num), int(dc.clk_cyc)


def log_exception():
    ''' Writes the last exception thrown to the error log file'''
    
    with open('output/errors.log','a+') as f:
        f.write(f'\nException caught at {datetime.datetime.now()}:\n')
        traceback.print_exc(file=f)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt: #exit gracefully since this is common
        exit(0)
    #except Exception as e:
        
        log_exception()
        #TODO
        print('Program exited with unexpected exception.')
        print('Please post to the Project Testing Framework discussion, and attach temp/errors.log')


