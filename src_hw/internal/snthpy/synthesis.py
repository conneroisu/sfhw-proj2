import os
import shutil
import subprocess
import datetime
import traceback
import build, parse_timings, generate_project as gp
import config_parser
import argparse

no_timings_message = '''
You're synthesis produced no timings. There are a couple reasons this could be, but first
you should look through the above output for any warnings. These assume your processor is
mostly working in the test framework

1. The processor doesn't have any outputs and was optimized away. This is most likely because
    you didn't connect the alu output to the skeleton code.

2. Your processor doesn't have any inputs and was optimized away. Most likely you modified
    the direct input to your IMEM instead of the provided proxy signal. The proxy signal
    is required so that we can forcibly load memory.

3. Your processor doesn't depend on the clock input. Perhaps you made your own clock in a
   process statment.

Check temp/synth_errors.log for more information.

'''

def main(args):

    # create temp directory if it doesn't exist
    os.makedirs('temp',exist_ok=True)
    
    config_parameters, env = config_parser.read_config(args.config)
    quartus_path = config_parameters.quartus

    # exit if quartus is not installed in the expected location
    if not os.path.isdir(quartus_path):
        print(r'Quartus is not installed in the expected location: ', quartus_path)
        print('If you are in the TLA, You can use the computers by the soldering irons, or the lab across the hallway')
        print('Additionally, if you are attempting a custom install, make sure to install quartus prime')
        exit(1)

    # list vhd files to include in the quartus project
    vhd_list = gp.find_vhd_files(dir='proj/src')
    if vhd_list == []:
        print('no vhd files were found')
        exit(1)

    # create quartus directory if it doesn't exist, if another process is using
    # The directory we need to exit
    try: 
        shutil.rmtree('internal/QuartusWork')
    except FileNotFoundError:
        pass
    except Exception as e: 
        print("Could not delete QuartusWork",e)
        exit(1)
    os.makedirs('internal/QuartusWork')

    gp.write_qsf(vhd_list,dir='internal/QuartusWork')
    gp.write_qpf(dir='internal/QuartusWork')
    gp.write_sdc(dir='internal/QuartusWork')

    build_success = build.build_all(config_parameters.quartus, env)
    if not build_success:
        print(no_timings_message)
        exit(1)

    parse_success = parse_timings.parse_timings()
    if not parse_success:
        exit(1)

    # Use Popen to start notepad in a non-blocking manner
    print('Timing results available in temp/timing.txt')

def log_exception():
    ''' Writes the last exception thrown to the error log file'''
    
    with open('temp/errors.log','a') as f:
        f.write(f'\nException caught at {datetime.datetime.now()}:\n')
        traceback.print_exc(file=f)

if __name__ == '__main__':
    try:
        parser = argparse.ArgumentParser()
        parser.add_argument('-c', '--config', help='Which config to use. Default=Lab', default="Lab")
        args = parser.parse_args()
        main(args)
    except KeyboardInterrupt: #exit gracefully since this is common
        exit(1)
    except Exception:
        log_exception()
        print('Program exited with unexpected exception.')
        print('Please post to the Project Testing Framework discussion, and attach temp/errors.log')
        
        
