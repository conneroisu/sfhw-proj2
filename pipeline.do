add wave -position insertpoint  \
vsim:/tb/MyMips/iCLK \
vsim:/tb/MyMips/iRST \

add wave -divider -height 20 $IF Stage \
vsim:/tb/MyMips/s_IF_PC4 \

add wave -divider -height 10 $ID Stage \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_ID_PC4 \

add wave -divider -height 10 $EX Stage \
vsim:/tb/MyMips/s_EXALUOp \
vsim:/tb/MyMips/s_EX_rs \
vsim:/tb/MyMips/s_EXrt \
vsim:/tb/MyMips/s_EXrd \
vsim:/tb/MyMips/s_EXrtrd \
vsim:/tb/MyMips/s_EX_PC4 \
vsim:/tb/MyMips/s_EXA \
vsim:/tb/MyMips/s_EXB \
vsim:/tb/MyMips/s_EXImmediate \
vsim:/tb/MyMips/s_EXRegDst \
vsim:/tb/MyMips/s_EXRegWr \
vsim:/tb/MyMips/s_EXmemToReg \
vsim:/tb/MyMips/s_EXMemWr \
vsim:/tb/MyMips/s_EXMemRd \
vsim:/tb/MyMips/s_EXALUSrc \
vsim:/tb/MyMips/s_EXjal \
vsim:/tb/MyMips/s_EXhalt \

add wave -divider -height 10 $MEM Stage \
vsim:/tb/MyMips/s_MEMALU \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_MEMjal \
vsim:/tb/MyMips/s_MEMmemtoReg \
vsim:/tb/MyMips/s_MEMhalt \
vsim:/tb/MyMips/s_MEMRegWr \
vsim:/tb/MyMips/s_DMemWr \ //not sure if this belongs here, it seems like its only actually used in the em/mem stage though
vsim:/tb/MyMips/s_DMemData \ // o_B => s_DMemData, in instEXMEM : EX_MEM? putting this im mem
vsim:/tb/MyMips/s_DMemOut \ 

add wave -divider -height 10 $WB Stage \ 
vsim:/tb/MyMips/s_WBALU \ //Outputted, not sure if used
vsim:/tb/MyMips/s_WBMEMOut \
vsim:/tb/MyMips/s_WBjal \
vsim:/tb/MyMips/s_WBmemToReg \
vsim:/tb/MyMips/s_WBRegWr \ //Passed Onto Regiser File
vsim:/tb/MyMips/s_WBrtrd \
vsim:/tb/MyMips/s_WB_PC4 \

add wave -divider -height 10 $IF Stage Passed Signals \
add wave -divider -heigth 10 $ID Stage Passed Signals \
add wave -divider -heigth 10 $EX Stage Passed Signals \
add wave -divider -heigth 10 $MEM Stage Passed Signals \
add wave -divider -heigth 10 $WB Stage Passed Signals \

add wave -divider -heigth 10 $MipsProcessor \ //idk where these should go based on mips processor file
vsim:/tb/MyMips/iInstLd \
vsim:/tb/MyMips/iInstAddr \
vsim:/tb/MyMips/iInstExt \
vsim:/tb/MyMips/oALUOut \
vsim:/tb/MyMips/s_DMemAddr \ //    s_DMemAddr  <= s_MEMALU; ????




add wave -divider -heigth 10 $Hazard/Forwarding \
vsim:/tb/MyMips/s_RegWr \ // I think this is hazard detection? its not in any stages
vsim:/tb/MyMips/s_RegWrAddr \
vsim:/tb/MyMips/s_RegWrData \
vsim:/tb/MyMips/s_IMemAddr \
vsim:/tb/MyMips/s_NextInstAddr \

vsim:/tb/MyMips/s_Inst \
vsim:/tb/MyMips/s_Halt \
vsim:/tb/MyMips/s_Ovfl \
vsim:/tb/MyMips/s_ForwardA_sel \
vsim:/tb/MyMips/s_ForwardB_sel \
vsim:/tb/MyMips/s_ALUOp \

vsim:/tb/MyMips/s_rtrd \


vsim:/tb/MyMips/s_RegA \
vsim:/tb/MyMips/s_RegB \


vsim:/tb/MyMips/s_MEM_PC4 \

vsim:/tb/MyMips/s_PC \
vsim:/tb/MyMips/s_PCR \
vsim:/tb/MyMips/s_nextPC \
vsim:/tb/MyMips/s_immediate \
vsim:/tb/MyMips/s_ALUB \
vsim:/tb/MyMips/s_aluORmem \


vsim:/tb/MyMips/s_ALUOut \


vsim:/tb/MyMips/s_ForwardA \
vsim:/tb/MyMips/s_ForwardB \
vsim:/tb/MyMips/s_BasedInstruction \
vsim:/tb/MyMips/s_JumpBranch \
vsim:/tb/MyMips/s_RegDst \
vsim:/tb/MyMips/s_memToReg \
vsim:/tb/MyMips/s_ALUSrc \
vsim:/tb/MyMips/s_j \
vsim:/tb/MyMips/s_Jr \
vsim:/tb/MyMips/s_Jal \
vsim:/tb/MyMips/s_NotClk \
vsim:/tb/MyMips/s_Signed \
vsim:/tb/MyMips/s_Lui \
vsim:/tb/MyMips/s_Operator \
vsim:/tb/MyMips/s_ShiftType \
vsim:/tb/MyMips/s_ShiftDirection \
vsim:/tb/MyMips/s_Bne \
vsim:/tb/MyMips/s_Beq \
vsim:/tb/MyMips/s_Branch \
vsim:/tb/MyMips/s_Jump \
vsim:/tb/MyMips/s_Zero \
vsim:/tb/MyMips/s_CarryOut \
vsim:/tb/MyMips/s_Stall \
vsim:/tb/MyMips/s_WE \
vsim:/tb/MyMips/s_Flush \
vsim:/tb/MyMips/s_ToFlush \
vsim:/tb/MyMips/s_muxRegWr \
vsim:/tb/MyMips/s_muxMemWr \
vsim:/tb/MyMips/s_internal_CarryOut \
vsim:/tb/MyMips/s_internal_Overflow \
vsim:/tb/MyMips/s_IDhalt \
vsim:/tb/MyMips/s_IDMemWr \
vsim:/tb/MyMips/s_IDRegWr \
vsim:/tb/MyMips/s_ID_memRD \


