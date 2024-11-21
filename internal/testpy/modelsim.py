import subprocess
import glob
import os
import pathlib
import re
import shutil
import time
from pathlib import Path

import logging
logger = logging.getLogger(__name__)

# used to see if output may have timed out but outputted correctly (meaning no halt signal)
expected_firstline = re.compile(r'In clock cycle:')


class Modelsim:
    """Implements a class for communicating with modelsim.
    """
    def __init__(self, modelsim_path, env):
        """Inits a new modelsim object.

        Args:
            modelsim_path : Path to modelsim
            env: Environment
            directory: Working directory for modelsim

        """
        self.modelsim_path = Path(modelsim_path)
        self.env = env

        if not self.modelsim_path.is_dir():
            raise FileNotFoundError

        logger.debug(f'New Modelsim runner, using modelsim {modelsim_path}')

    def prepare_lib(self, dest):
        '''Inits a new library to compile into.

        Args:
            dest : Destination of new library

        Returns:
            True if success, else false
        '''

        try:
            shutil.rmtree(dest) # delete a non empty directory
        except FileNotFoundError as e:
            logger.info(f'Directory {dest} not found')
            pass # It is fine if the directory already doesn't exist
        except Exception as e:
            logger.warning(f'Directory {dest} could not be created')
            return False

        # Create work folder for compiled work
        try:
            logger.info(f'Creating library {dest}')
            subprocess.check_output( 
                [f'{self.modelsim_path}/vlib', dest], env=self.env) 
        except:
            logger.warning(f'Directory {dest} could not be created')
            return False


    def compile(self, dest, compile_log):
        '''Compiles 1 or more source files into a library.

        Args:
            dest : destination library

        Returns : true if succeeded, else errors.
            
        '''

        to_compile = []

        if pathlib.Path('proj/src/MIPS_types.vhd').is_file():
            logger.info(f'Found MIPS_types file')
            to_compile.append("proj/src/MIPS_types.vhd")

        to_compile.append("internal/testpy/tb.vhd")
    
        for f in glob.iglob("proj/src/**/*.vhd", recursive=True):
            logger.info(f'Found {f}')
            to_compile.append(f)

    
        try:
            with open(compile_log, 'w') as f:
                exit_code = subprocess.call(
                    [f'{self.modelsim_path}/vcom','-2008','-work', dest] + to_compile,
                    stdout=f,
                    stderr=subprocess.STDOUT,
                    timeout=60,
                    env=self.env
                )
        except subprocess.TimeoutExpired:
            return False
    
        if(exit_code != 0):
            return False
    
        return True
    

    def sim(self, directory, modelsim_trace, vsim_log, timeout=30):
        '''
        Simulates testbench. All work should be compiled before this method is called
        Returns True if the simulation was successful, otherwise False
        '''
        ret = None  # This is a return message. Only set it if simulation fails. The caller will print it.
        directory = Path(directory)
    
        # We can't use timeout here because of this bug, so use GNU timeout
        # https://bugs.python.org/issue37424

        with open(directory / vsim_log, 'w') as sim_log:
            try:
                exit_code = subprocess.call(
                    ['timeout', str(timeout), f'{self.modelsim_path}/vsim', '-postsimdataflow', '-debugdb', '-c','-voptargs="+acc"','tb','-do','modelsim_framework.do', f'-gOUTPUT_TRACE={modelsim_trace}', ],
                    stdout=sim_log,
                    stderr=sim_log,
                    cwd=directory,
                    timeout=timeout+5, # If the do file doesn't reach the 'quit' we need to manually kill the process 
                    env=self.env
                )
            except subprocess.TimeoutExpired as e:
                exit_code = 124

        trace = directory / modelsim_trace

        trace.touch()
    
        # check if process exited with error.
        if(exit_code == 124):
            if self.timeout_is_nohalt(modelsim_trace):
                ret = '** Warning: Simulation timed out, but produced some valid output, most likely the halt signal is incorrect or the application contains an infinite loop **'
            else:
                # close the simulation with a failure since the simulation didn't produce a valid output
                ret = 'Simulation timed out (if you think this was a mistake you can increase the time to more than 30 seconds explicitly via --sim-timeout)\n'
        elif(exit_code != 0):
            ret = f'could not simulate successfully, got exit code {exit_code}'
    
        return ret
    
    
    def timeout_is_nohalt(self, trace):
        '''
        Opens dump file to check if file is formatted correctly despite process timing out.
        This would indicate that no halt signal was implemented, but simulation was correct otherwise.
    
        Retuns False if halt didn't cause the time out
            , True if it may have times out because of halt
        '''
        trace = Path(trace)
        if not trace.is_file():
            return False
    
        with open(trace, 'r') as f:
            firstline = f.readline()
        
        return expected_firstline.match(firstline)
    
    def busy_move(self, src,dest,timeout=5,missingok=False):
        '''
        Sometimes when modelsim is timed out it still holds some file resources, preventing the files
        from being deleted or moved. This is just shutil.move wrapped so that it busy-waits by retrying
        until the resource is released.
        '''
        s = time.time()
        while True:
            try:
                shutil.move(src,dest)
                return
            except FileNotFoundError as e:
                if not missingok: 
                    raise e # re-raise if user did not allow file to not exist
            except PermissionError as e:
                if time.time() - s > timeout:
                    raise e  # stop trying if we have reached the timeout
            
    @staticmethod
    def is_installed(config, env):
        '''
        Returns True if modelsim is installed on the computer in the expected location
        Checkes the config file to verify if a custom path should be used.
        '''
        modelsim_path = config.modelsim
        if modelsim_path is None:
            return False
        is_dir = os.path.isdir(modelsim_path)
    
        return is_dir

