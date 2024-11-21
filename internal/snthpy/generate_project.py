import os
import glob
import re

project_name='toolflow'
top_level_entity = 'MIPS_Processor'

base_qsf = r'''
#
# CprE 381 Generated Quartus Settings File
#

set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE115F29C7
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 21.1.1
set_global_assignment -name PROJECT_CREATION_TIME_DATE "19:07:08  JANUARY 28, 2019"
set_global_assignment -name LAST_QUARTUS_VERSION "21.1.1 Standard Edition"
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
set_global_assignment -name TOP_LEVEL_ENTITY {}
set_global_assignment -name VHDL_INPUT_VERSION VHDL_2008
'''

base_qpf = r'''
#
# CprE 381 Generated Quartus Project File
#
QUARTUS_VERSION = "18.0"
DATE = "19:07:08  January 28, 2019"\n

PROJECT_REVISION = {}
'''

base_sdc = r'''
#
# CprE 381 Generated Quartus SDC file
#

#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3

#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {iCLK} -period 20.000 -waveform { 0.000 10.000 } [get_ports { iCLK }]

#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {iCLK}] -rise_to [get_clocks {iCLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {iCLK}] -fall_to [get_clocks {iCLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iCLK}] -rise_to [get_clocks {iCLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iCLK}] -fall_to [get_clocks {iCLK}]  0.020  
'''

vhd_regex = re.compile(r'.*\.vhd')
vhd_ignore = {'tb.vhd'}

def find_vhd_files(dir='proj/src'):
    '''
    Search source directory for .vhd files.

    Returns a list of os.DirEntry objects that are vhdl files
    '''

    return glob.glob(dir+"/**/*.vhd", recursive=True)


def write_qsf(vhd_list, dir="."):
    '''
    Writes a Quartus .qsf file with the correct source files listed, and the correct top-level-entity 

    Arguments:
    vhd_list -- a list of os.DirEntry objects which are files with the .vhd extension
    '''
    with open(f'{dir}/{project_name}.qsf','w') as qsf_file: # open the new .qsf file in write mode
        qpf_str = base_qsf.format(top_level_entity) # format the base string with the top level entity name
        qsf_file.write(qpf_str) # write the qpf contents to the file
        
        # Map the os.DirEntry objects into path strings and then sort for a more readable output
        path_list = list(
            map(
                # Use absolute path, with forward-slashes
                lambda f: os.path.abspath(f).replace('\\','/'), 
                vhd_list)
                )
        path_list.sort()

        # Write the path for each file into the the .qsf file in th correct format
        for src_file in path_list:
            qsf_file.write(f'set_global_assignment -name VHDL_FILE "{src_file}"\n')
        
        qsf_file.flush()


def write_qpf(dir="."):
    with open(f'{dir}/{project_name}.qpf','w') as qpf_file: # open the new .qpf file in write mode
        qpf_file.write(base_qpf.format(top_level_entity)) # write the formatted string to the file

        qpf_file.flush()


def write_sdc(dir="."):
    with open(f'{dir}/{project_name}.sdc','w') as sdc_file: # open the new .qpf file in write mode
        sdc_file.write(base_sdc) # write the base string to the file

        sdc_file.flush()
