import subprocess
import pathlib
import os
import datetime as dt
import generate_project as gp
import config_parser

r'''
:temporary script for testing
C:\intelFPGA\18.1\quartus\bin64\quartus_map --read_settings_files=on --write_settings_files=off qs2 -c qs2

C:\intelFPGA\18.1\quartus\bin64\quartus_fit --read_settings_files=off --write_settings_files=off qs2 -c qs2
C:\intelFPGA\18.1\quartus\bin64\quartus_asm --read_settings_files=off --write_settings_files=off qs2 -c qs2
C:\intelFPGA\18.1\quartus\bin64\quartus_sta --sdc="qs2.sdc" qs2 --do_report_timing
'''

def build_all(quartus, env, ddir='internal/QuartusWork'):
    """ Builds the project and generates a timing summary

    Args:
        quartus: Path to quartus bin directory.
        env: Environment to use. Useful if adding a license server.
        ddir: Directory to use as quartus working directory

    Returns:
        True if success, else fail
    """
    pname = gp.project_name
    starttime = dt.datetime.now()

    print(f'\nStarting compilation at {str(starttime)}\n')

    with open('temp/synth_error.log','w') as synth_log:

        # starting mapping
        exit_code = subprocess.call(
            [f'{quartus}/quartus_map','--read_settings_files=on','--write_settings_files=off',pname,'-c',pname],
            cwd=ddir,
            stdout = synth_log,
            stderr = synth_log,
            env=env
        )

        if exit_code != 0:
            print('Error during compilation or mapping')
            return False

        # starting fitting
        exit_code = subprocess.call(
            [f'{quartus}/quartus_fit','--read_settings_files=on','--write_settings_files=off',pname,'-c',pname],
            cwd=ddir,
            stdout = synth_log,
            stderr = synth_log,
            env=env
        )

        if exit_code != 0:
            print('Error during fitting')
            return False

        # starting assembly
        exit_code = subprocess.call(
            [f'{quartus}/quartus_asm','--read_settings_files=on','--write_settings_files=off',pname,'-c',pname],
            cwd=ddir,
            stdout = synth_log,
            stderr = synth_log,
            env=env
        )

        if exit_code != 0:
            print('Error during assembly')
            return False

    # generate timing
    with open('temp/timing_dump.txt','w') as timing_log:
        exit_code = subprocess.call(
            [f'{quartus}/quartus_sta',f'--sdc={pname}.sdc',pname,'--do_report_timing'],
            cwd=ddir,
            stdout = timing_log,
            env=env
        )

        if exit_code != 0:
            print('Error during assembly')
            return False

    endtime = dt.datetime.now()
    print('\nTiming generation complete!')
    print(f'completed in {str(endtime-starttime)}')

    return True

