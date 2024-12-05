#!/bin/bash

FILES=(./proj/mips/*.s)
for ((i=0; i<${#FILES[@]}; i+=5)); do
    for ((j=i; j<i+5 && j<${#FILES[@]}; j++)); do
        ./381_sim "${FILES[j]}" test -d DEBUG &
    done
    wait
done
