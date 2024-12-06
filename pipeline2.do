add wave -position insertpoint  \
vsim:/tb/MyMips/iCLK \
vsim:/tb/MyMips/iRST \
vsim:/tb/MyMips/s_Stall \
add wave -divider What #Optional \
vsim:/tb/MyMips/s_IF_PC4 \
vsim:/tb/MyMips/s_BasedInstruction \
add wave -divider IF/ID_Stage #Optional \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_ID_PC4 \
add wave -divider  IF/ID_Output #Optional \
vsim:/tb/MyMips/s_ID_PC4 \
vsim:/tb/MyMips/s_RegA \
vsim:/tb/MyMips/s_RegB \
vsim:/tb/MyMips/s_immediate \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_RegDst \
vsim:/tb/MyMips/s_muxRegWr \
vsim:/tb/MyMips/s_memToReg \
vsim:/tb/MyMips/s_muxMemWr \
vsim:/tb/MyMips/s_ALUSrc \
vsim:/tb/MyMips/s_ALUOp \
vsim:/tb/MyMips/s_Jal \
vsim:/tb/MyMips/s_IDhalt \
vsim:/tb/MyMips/s_ID_memRD \
add wave -divider ID/EX_Stage #Optional \
vsim:/tb/MyMips/s_EX_rs \
vsim:/tb/MyMips/s_EX_PC4 \
vsim:/tb/MyMips/s_EXA \
vsim:/tb/MyMips/s_EXB \
vsim:/tb/MyMips/s_EXImmediate \
vsim:/tb/MyMips/s_EXrt \
vsim:/tb/MyMips/s_EXrd \
vsim:/tb/MyMips/s_EXRegDst \
vsim:/tb/MyMips/s_EXRegWr \
vsim:/tb/MyMips/s_EXmemToReg \
vsim:/tb/MyMips/s_EXMemWr \
vsim:/tb/MyMips/s_EXALUSrc \
vsim:/tb/MyMips/s_EXALUOp \
vsim:/tb/MyMips/s_EXjal \
vsim:/tb/MyMips/s_EXhalt \
vsim:/tb/MyMips/s_EXMemRd \
add wave -divider ID/EX_Output #Optional \
vsim:/tb/MyMips/s_ALUOut \
vsim:/tb/MyMips/s_ForwardB \
vsim:/tb/MyMips/s_EXrtrd \
vsim:/tb/MyMips/s_EXMemWr \
vsim:/tb/MyMips/s_EXmemToReg \
vsim:/tb/MyMips/s_EXhalt \
vsim:/tb/MyMips/s_EXRegWr \
vsim:/tb/MyMips/s_EXjal \
vsim:/tb/MyMips/s_EX_PC4 \
add wave -divider EX/MEM_Stage #Optional \
vsim:/tb/MyMips/s_MEMALU \
vsim:/tb/MyMips/s_DMemData \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_DMemWr \
vsim:/tb/MyMips/s_MEMmemToReg \
vsim:/tb/MyMips/s_MEMhalt \
vsim:/tb/MyMips/s_MemRegWr \
vsim:/tb/MyMips/s_MEMjal \
vsim:/tb/MyMips/s_MEM_PC4 \
add wave -divider EX/MEM_Output #Optional \
vsim:/tb/MyMips/s_MEMALU \
vsim:/tb/MyMips/s_DMemOut \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_MEMmemToReg \
vsim:/tb/MyMips/s_MEMHalt \
vsim:/tb/MyMips/s_MEMRegWr \
vsim:/tb/MyMips/s_MEMjal \
vsim:/tb/MyMips/s_MEM_PC4 \
add wave -divider MEM/WB_Stage #Optional \
vsim:/tb/MyMips/s_WBALU \
vsim:/tb/MyMips/s_WBMEMOut \
vsim:/tb/MyMips/s_WBrtrd \
vsim:/tb/MyMips/s_WBmemToReg \
vsim:/tb/MyMips/s_Halt \
vsim:/tb/MyMips/s_WBRegWr \
vsim:/tb/MyMips/s_WBjal \
vsim:/tb/MyMips/s_WB_PC4 \
add wave -divider MEM/WB_Output #Optional \
vsim:/tb/MyMips/s_EX_rs \
vsim:/tb/MyMips/s_EXrt \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_WBrtrd \
vsim:/tb/MyMips/s_MemRegWr \
vsim:/tb/MyMips/s_WBRegWr \
add wave -divider Forward_Unit #Optional \
vsim:/tb/MyMips/s_ForwardA_sel \
vsim:/tb/MyMips/s_ForwardB_sel \
add wave -divider Forward_Output #Optional \
vsim:/tb/MyMips/s_Jump \
vsim:/tb/MyMips/s_JumpBranch \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_EXrtrd \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_EXRegWr \
vsim:/tb/MyMips/s_MemRegWr \
add wave -divider Hazard_Unit #Optional \
vsim:/tb/MyMips/s_Stall \
vsim:/tb/MyMips/s_Flush \
add wave -divider Hazard_Output #Optional
