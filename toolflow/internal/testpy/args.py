import os
import argparse

def set_args(parser: argparse.ArgumentParser):
    _ = parser.add_argument('files', type=check_asm_file, nargs='+', help='Assembly files to run. 1 or more files are accepted, including wildcards. preface a filename with @filename to use as a list of files.')
    _ = parser.add_argument('--max-mismatches', type=check_max_mismatches ,default=3, help='Number of incorrect instructions to print before the program claims failure, default=3')
    _ = parser.add_argument('--nocompile', action='store_true',  help='flag used to disable compilation in order to save time')
    _ = parser.add_argument('-s', '--summary', action='store_true',  help='Display minimal output.')
    _ = parser.add_argument('--sim-timeout',type=check_sim_timeout, default=30, help='change the ammount of time before simulation is forcefully stopped')
    _ = parser.add_argument('-c', '--config', help='Which config to use. Default=Lab', default="Lab")
    _ = parser.add_argument('-j', '--jobs', type=check_jobs, help='Number of simulation jobs. Use 0 to match the number of CPUs available on the system.', default=1)
    _ = parser.add_argument('-d', '--debug', choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'], default='CRITICAL', help="Sets debug level")


def check_jobs(v):
    v = int(v)
    if v < 0:
        return 1
    elif v == 0:
        return os.cpu_count()
    else:
        return v

def check_asm_file(v: str):
    if os.path.exists(v):
        return v
    else:
        raise argparse.ArgumentTypeError(f'File {v} not found')

def check_sim_timeout(v):
    ivalue = int(v)
    if ivalue <= 0:
        raise argparse.ArgumentTypeError('--sim-timeout should be a positive integer')
    return ivalue

def check_max_mismatches(v):
    ivalue = int(v)
    if ivalue <= 0:
        raise argparse.ArgumentTypeError('--max-mismatches should be a positive integer')
    return ivalue

