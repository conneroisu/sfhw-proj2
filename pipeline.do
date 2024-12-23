add wave -position insertpoint \
-color yellow \
vsim:/tb/MyMips/s_Stall \
vsim:/tb/MyMips/s_Flush \
add wave -divider Hazard_Output #Optional \
-color yellow \
vsim:/tb/MyMips/s_Jump \
vsim:/tb/MyMips/s_JumpBranch \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_EXrtrd \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_EXRegWr \
vsim:/tb/MyMips/s_MemRegWr \
add wave -divider Hazard_Unit #Optional \
-color magenta \
vsim:/tb/MyMips/s_ForwardA_sel \
vsim:/tb/MyMips/s_ForwardB_sel \
add wave -divider Forward_Output #Optional \
-color magenta \
vsim:/tb/MyMips/s_EX_rs \
vsim:/tb/MyMips/s_EXrt \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_WBrtrd \
vsim:/tb/MyMips/s_MemRegWr \
vsim:/tb/MyMips/s_WBRegWr \
add wave -divider Forward_Unit #Optional \
-color lime \
vsim:/tb/MyMips/s_WBALU \
vsim:/tb/MyMips/s_WBMEMOut \
vsim:/tb/MyMips/s_WBrtrd \
vsim:/tb/MyMips/s_WBmemToReg \
vsim:/tb/MyMips/s_Halt \
vsim:/tb/MyMips/s_WBRegWr \
vsim:/tb/MyMips/s_WBjal \
add wave -divider MEM/WB_Output #Optional \
-color cyan \
vsim:/tb/MyMips/s_MEMALU \
vsim:/tb/MyMips/s_DMemOut \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_MEMmemToReg \
vsim:/tb/MyMips/s_MEMHalt \
vsim:/tb/MyMips/s_MEMRegWr \
vsim:/tb/MyMips/s_MEMjal \
vsim:/tb/MyMips/s_MEM_PC4 \
add wave -divider MEM/WB_Stage #Optional \
-color lime \
vsim:/tb/MyMips/s_MEMALU \
vsim:/tb/MyMips/s_DMemData \
vsim:/tb/MyMips/s_MEMrtrd \
vsim:/tb/MyMips/s_MEMhalt \
vsim:/tb/MyMips/s_MEMjal \
add wave -divider EX/MEM_Output #Optional \
-color cyan \
vsim:/tb/MyMips/s_ALUOut \
vsim:/tb/MyMips/s_ForwardB \
vsim:/tb/MyMips/s_EXrtrd \
vsim:/tb/MyMips/s_EXMemWr \
vsim:/tb/MyMips/s_EXhalt \
vsim:/tb/MyMips/s_EXjal \
add wave -divider EX/MEM_Stage #Optional \
-color lime \
vsim:/tb/MyMips/s_EX_rs \
vsim:/tb/MyMips/s_EXA \
vsim:/tb/MyMips/s_EXB \
vsim:/tb/MyMips/s_EXImmediate \
vsim:/tb/MyMips/s_EXrt \
vsim:/tb/MyMips/s_EXrd \
vsim:/tb/MyMips/s_EXRegDst \
vsim:/tb/MyMips/s_EXjal \
vsim:/tb/MyMips/s_EXhalt \
vsim:/tb/MyMips/s_EXMemRd -color pink\
vsim:/tb/MyMips/s_ALUOut \
vsim:/tb/MyMips/s_Zero \
add wave -divider ID/EX_Output #Optional \
-color cyan \
vsim:/tb/MyMips/s_RegA \
vsim:/tb/MyMips/s_RegB \
vsim:/tb/MyMips/s_immediate \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_RegDst \
vsim:/tb/MyMips/s_ALUSrc \
vsim:/tb/MyMips/s_ALUOp \
vsim:/tb/MyMips/s_Jal \
vsim:/tb/MyMips/s_IDhalt \
vsim:/tb/MyMips/s_ID_memRD -color pink\
vsim:/tb/MyMips/s_ForwardA \
vsim:/tb/MyMips/s_ALUB \
add wave -divider ID/EX_Stage #Optional \
-color lime \
vsim:/tb/MyMips/s_ID_Inst \
vsim:/tb/MyMips/s_ID_PC4 \
add wave -divider  IF/ID_Output #Optional \
-color cyan \
vsim:/tb/MyMips/s_IF_PC4 \
vsim:/tb/MyMips/s_BasedInstruction \
add wave -divider IF/ID_Stage #Optional \
-color lime \
vsim:/tb/MyMips/iCLK \
vsim:/tb/MyMips/iRST \
vsim:/tb/MyMips/s_Stall \
add wave -divider Control #Optional