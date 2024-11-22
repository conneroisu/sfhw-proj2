import os
import re

#indent_regex = re.compile('    .*')
start_line = 'Info: Analyzing Slow 1200mV 85C Model'
slack_regex = re.compile(r'.*Worst case slack is (?P<slack>-?[0-9]+\.[0-9]+)')
path_start = re.compile(r'Info \([0-9]+\): Path #1: Setup slack is -?[0-9]+\.[0-9]+( \(VIOLATED\))?')
path_regex = re.compile(r'    Info \([0-9]+\):(?P<body>.*)') # the dunp is indented with 4 spaces

# should be formatted to include the slack time
timing_base = r'''
#
# CprE 381 toolflow Timing dump
#

FMax: {0:.2f}mhz Clk Constraint: {1:.2f}ns Slack: {2:.2f}ns

The path is given below

'''


def parse_timings():
    with open('temp/timing_dump.txt') as dump, open('temp/timing.txt','w') as outfile:
        return read_timings(dump,outfile)

def read_timings(infile,outfile):
    '''
    Parses timings from quartus dump.
    returns True if some data was parsed, False otherwise
    '''

    # Algorithm:
    # Made to use the Quartus timing dump format.
    # It iterates through each line and checks if it is part of the current parse mode.
    # If it is not, it moves onto the next parse mode, this makes use of the rigid file format,
    # especially the fact that the worst-case path is always reported first.
    #
    # preamble -> slack search -> path start -> path body

    # parse modes are used based on what information we are looking for.
    # options are:
    # 'preamble' -> mode for skipping to the part we are interested in
    # 'slack search' -> mode for when we are looking for the worst case slack
    # 'path-start' -> get the top level line detailed path for the worst-case path
    # 'path-body' -> get the path itself for the path
    parse_mode = 'preamble'

    read_some = False # use flag to make sure some timing was read

    # read file line by line
    for rawline in infile:

        line = rawline.rstrip() # strip line endings

        if parse_mode == 'preamble':  
            # here we are just looking for the line with the timing mode we want
            if line == start_line:
                # print('got to slack search')
                parse_mode = 'slack search'

        elif parse_mode == 'slack search':
            search = slack_regex.fullmatch(line)
            if search:
                slack = search.group('slack')
                outfile.write(format_timing(slack))
                parse_mode = 'path start'

        elif parse_mode == 'path start':
            search = path_start.fullmatch(line)
            if search:
                # print('got to path start')
                parse_mode = 'path body'

        elif parse_mode == 'path body':
            read_some = True
            search = path_regex.fullmatch(line)
            if search:
                outfile.write(search.group('body')+'\n')
            else:
                break
    
    return read_some
        

def format_timing(slack):
    '''
    Returns the formatted base for the timing_dump with FMax, clock constraint, and slack filled in

    slack should be an float as a string, in nanoseconds
    '''

    slackfloat = float(slack) # ns
    period = 20-slackfloat # ns
    fmax = 1000/period # mhz

    return timing_base.format(fmax,20.0,slackfloat)
