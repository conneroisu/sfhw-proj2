
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
