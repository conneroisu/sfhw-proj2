#! /bin/bash

#@brief This script provides a basic runner for the 381 Toolflow
#
#@author Braedon Giblin <bgiblin@iastate.edu>
#@date 2022.02.10
#

PYTHON3_VDI=/usr/local/mentor/calibre/bin/python3
PYTHON3_LAB=/bin/python3

red='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if the user has passed a PYTHON var
if [ -z ${python3+x} ]; then
    if [ -f "$PYTHON3_VDI" ]; then
        PYTHON=$PYTHON3_VDI
        echo "Using VDI Python Environment"
    elif [ -f "$PYTHON3_LAB" ]; then
        PYTHON=$PYTHON3_LAB
        echo "Using LAB Python Environment"
    else
        echo -e "${RED}Python Missing... Try running this with PYTHON=path/to/python3 ./381_tf.sh${NC}"
        exit 1
    fi
else
    if [ -f "$PYTHON" ]; then
        echo "Using $PYTHON"
    else
        echo -e "${RED}Provided Python path $PYTHON does not exists ${NC}"
        exit 1
    fi
fi

if [ "$1" == "new" ]; then
    if [ -d "proj" ]; then
        echo -e "${RED}Projet already exists, trying moving your extiing project using the 'mov' *nix command${NC}"
    else
        mkdir -p "proj"
        mkdir -p "proj/src"
        mkdir -p "proj/test"
        mkdir -p "proj/mips"
        touch "proj/test/.gitkeep"
        cp -r "internal/boilerplate_src/"* "proj/src"
        cp -r "internal/boilerplate_mips/"* "proj/mips"
        echo "New project Created"
    fi
elif [ "$1" == "test" ]; then
    echo "Testing"
    $PYTHON internal/testpy/test_framework.py "${@:2}"
elif [ "$1" == "synth" ]; then
    echo "Synth"
    $PYTHON internal/snthpy/synthesis.py "${@:2}"
elif [ "$1" == "submit" ]; then
    if [ ! -d "proj" ]; then
        echo -e "${RED}Project 'proj' doesn't exist${NC}"
        echo -e "${RED}Please make sure your project exists at ./proj/ ${NC}"
        exit 1
    fi
    if [ ! -n "$(ls -A proj/src/*.vhd 2>/dev/null )" ]; then
        echo -e "${RED}Missing proj/src diretory (or no vhd files present)${NC}"
        exit 1
    fi
    if [ ! -n "$(ls -A proj/mips/*.s 2>/dev/null)" ]; then
        echo -e "${RED}Missing proj/mips diretory (or no s files present)${NC}"
        exit 1
    fi
    if [ ! -n "$(ls -A proj/test/*.vhd 2>/dev/null)" ]; then
        echo -e "${RED}Missing proj/test diretory (or no vhd files present)${NC}"
        exit 1
    fi
    if [ ! -f "proj/"*".pdf" ]; then
        echo -e "${RED}Missing report PDF (proj/*.pdf)${NC}"
        echo -e "${RED}Please export your report to PDF, and place in the ${NC}"
        echo -e "${RED}'proj' directory${NC}"
        exit 1
    fi
    if [ $# == 2 ]; then
        proj1=0
        if [ "$2" == "sw" ]; then
            suff="_proj2_sw"
        elif [ "$2" == "hw" ]; then
            suff="_proj2_hw"
        else
            echo -e "${RED}Argument for submit [$2] not recognized${NC}"
            echo -e "${ORANGE}Accepted options are 'hw' or 'sw' or nothing.${NC}"
            exit 1
        fi
        echo -e "${GREEN}Making Project 2 Submission${NC}"
    else
        proj1=1

        if [ -f "proj/"*".xls" ]; then
            echo -e "${GREEN}Found possible .xls file for control signals${NC}"
        elif [ -f "proj/"*".xlsx" ]; then
            echo -e "${GREEN}Found possible .xlsx file for control signals${NC}"
        elif [ -f "proj/"*".csv" ]; then
            echo -e "${GREEN}Found possible .csv file for control signals${NC}"
        else
            echo -e "${ORANGE}Did not find a .xls, .xlsx, or .csv file for control signals.\nPlease include this file, or ignore if you already included it in your report."
        fi
        suff=_proj1
        echo -e "${GREEN}Making Project 1 Submission${NC}"

    fi

    echo "Creating submission in submissions/"
    echo "When submitting to Canvas, please make sure to upload both the .zip"
    echo "directory and the pdf as a submission. All files needed for submisison"
    echo "are included in the submission directory."
    mkdir -p "submissions/"
    cp -r "proj/src" "submissions"
    cp -r "proj/mips" "submissions"
    cp -r "proj/test" "submissions"
    cp  "proj/"*".pdf" "submissions" 2>/dev/null
    cp  "proj/"*".xls" "submissions" 2>/dev/null
    cp  "proj/"*".csv" "submissions" 2>/dev/null
    cp  "proj/"*".xlsx" "submissions" 2>/dev/null
    (cd "submissions" && zip --quiet -r "submit${suff}.zip" *)
    rm -rf "submissions/src"
    rm -rf "submissions/mips"
    rm -rf "submissions/test"
    if [ $proj1 == 1 ]; then
        mkdir -p "submissions/proj1"
        mv "submissions/submit${suff}.zip" "submissions/proj1"
    else
        mkdir -p "submissions/proj2"
        mv "submissions/submit${suff}.zip" "submissions/proj2"
    fi
    
else
    echo "==========================================================================================="
    echo "   _____ _____  _____    ______   ____   ___  __   _______          _  __ _                "
    echo "  / ____|  __ \|  __ \  |  ____| |___ \ / _ \/_ | |__   __|        | |/ _| |               "
    echo " | |    | |__) | |__) | | |__      __) | (_) || |    | | ___   ___ | | |_| | _____      __ "
    echo " | |    |  ___/|  _  /  |  __|    |__ < > _ < | |    | |/ _ \ / _ \| |  _| |/ _ \ \ /\ / / "
    echo " | |____| |    | | \ \  | |____   ___) | (_) || |    | | (_) | (_) | | | | | (_) \ V  V /  "
    echo "  \_____|_|    |_|  \_\ |______| |____/ \___/ |_|    |_|\___/ \___/|_|_| |_|\___/ \_/\_/   "
    echo "==========================================================================================="
    echo "Welcome to CPR E 381 Toolflow."
    echo "This toolflow may be used to test and synthesize your code, as well as provide a submission"
    echo "template for Canvas. For more information on this tool, please see the attached manual file."
    echo "The general workflow for this toolflow is to "
    echo -e " \t 1) create a project using the 'new' command. "
    echo " "
    echo -e " \t 2) Build your MIPS processor in the created 'proj' directory using your editor of choice. "
    echo "You may create subdirectoryies in both the MIPS and the SRC folder to encompass your tests."
    echo " "
    echo -e " \t 3) Test your MIPS processor frequently as you go. The toolflow supports testing for both"
    echo "provided unit tests, as well as your own tests. See the documentation for a desription on how"
    echo "to properly test your processr." 
    echo " "
    echo -e " \t 4) Synthesis framework. This framework allows you to synthesize"
    echo "your MIPS processor using the Altera Quartus toolflow. Be aware... This synthesis often takes"
    echo "some time to run. Your final outputs from the synthesis will be a timing summary, in which"
    echo "you may extrapolate the critical path  of your processor. "
    echo " "
    echo -e " \t 5) The last goal of this toolflow is to sanity check and package your submissision. Please "
    echo "pay attention to the submission guidelines highlighted in your lab documentation, and ensure "
    echo "that the submission .zip and report generated matches what you intend to submit. Upload all "
    echo "files to Canvas as a single group submission."
    echo " "
    echo -e "${BLUE} Supported Toolflow operations${NC}"
    echo " Please contact your TA / professor with any toolflow bugs encountered!"
    echo " "
    echo -e  "${ORANGE}To initialize your project: ${NC}"
    echo " "
    echo "./381_tf.sh new "
    echo " "
    echo -e "${ORANGE}To test your code: ${NC}"
    echo " "
    echo "./381_tf.sh test <options>"
    echo " "
    echo "You may use the option -h or --help when calling test to print a test help message with all options"
    echo " "
    echo -e "${ORANGE}To synthesize: ${NC}"
    echo " "
    echo "./381_tf.sh synth"
    echo " "
    echo -e "${ORANGE}To generate/check submission: ${NC}"
    echo " "
    echo "./381_tf.sh submit"
    echo "./381_tf.sh submit hw"
    echo "./381_tf.sh submit sw"
fi
