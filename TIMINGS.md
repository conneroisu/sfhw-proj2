# TIMINGS.md

## Purpose

The purpose of this `TIMINGS.md` file is to provide a guide for interpreting the timing outputs of the toolflow. The timing outputs are located in the `src_hw/temp/timing.txt`, `src_sc/temp/timing.txt`, and `src_sw/temp/timing.txt` files.

## Structure of Timing Output Files

The timing output files have a specific structure that includes the following sections:
- FMax: The maximum frequency at which the design can operate.
- Clock Constraint: The clock period constraint for the design.
- Slack: The difference between the required time and the arrival time of a signal.
- Data Arrival Path: The path taken by the data signal from the source to the destination.

## Understanding FMax, Clock Constraints, and Slack

### FMax
FMax is the maximum frequency at which the design can operate without violating any timing constraints. It is calculated as the inverse of the clock period.

### Clock Constraints
Clock constraints define the required clock period for the design. It is the maximum allowable time for a signal to propagate from one register to another.

### Slack
Slack is the difference between the required time and the arrival time of a signal. Positive slack indicates that the design meets the timing constraints, while negative slack indicates a timing violation.

## Data Arrival Path

The data arrival path section provides a detailed explanation of the path taken by the data signal from the source to the destination. It includes the following information:
- From Node: The starting point of the data signal.
- To Node: The destination point of the data signal.
- Launch Clock: The clock signal that triggers the data signal.
- Latch Clock: The clock signal that captures the data signal.
- Data Arrival Path: A detailed breakdown of the time taken by the data signal to propagate through various elements in the design.

### Explanation of Data Arrival Path Elements

- **Total (ns)**: The cumulative time taken by the data signal to propagate through the design up to that point.
- **Incr (ns)**: The incremental time taken by the data signal to propagate through the current element.
- **Type**: The type of element (e.g., R for register, IC for interconnect, CELL for cell, etc.).
- **Element**: The specific element in the design through which the data signal is propagating.

## Examples

### Example from `src_hw/temp/timing.txt`

```
FMax: 48.38mhz Clk Constraint: 20.00ns Slack: -0.67ns

The path is given below

 ===================================================================
 From Node    : mem:DMem|altsyncram:ram_rtl_0|altsyncram_eg81:auto_generated|ram_block1a0~porta_we_reg
 To Node      : EX_MEM:instEXMEM|dffg:\G_ALU_Reg:31:ALUDFFGI|s_Q
 Launch Clock : iCLK
 Latch Clock  : iCLK
 Data Arrival Path:
 Total (ns)  Incr (ns)     Type  Element
 ==========  ========= ==  ====  ===================================
      0.000      0.000           launch edge time
      3.387      3.387  R        clock network delay
      3.650      0.263     uTco  mem:DMem|altsyncram:ram_rtl_0|altsyncram_eg81:auto_generated|ram_block1a0~porta_we_reg
      6.499      2.849 FR  CELL  DMem|ram_rtl_0|auto_generated|ram_block1a0|portadataout[0]
      7.284      0.785 RR    IC  instRegAddrMux|\G_NBit_MUX:0:MUXI|o_o~0|datad
      7.439      0.155 RR  CELL  instRegAddrMux|\G_NBit_MUX:0:MUXI|o_o~0|combout
      7.641      0.202 RR    IC  instRegAddrMux|\G_NBit_MUX:0:MUXI|o_o~1|datad
      7.796      0.155 RR  CELL  instRegAddrMux|\G_NBit_MUX:0:MUXI|o_o~1|combout
      8.573      0.777 RR    IC  instImmMux|\G_NBit_MUX:0:MUXI|o_o~3|datad
      8.728      0.155 RR  CELL  instImmMux|\G_NBit_MUX:0:MUXI|o_o~3|combout
      9.444      0.716 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:0:FullAdderI|or1|o_f~0|datad
      9.599      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:0:FullAdderI|or1|o_f~0|combout
      9.826      0.227 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:1:FullAdderI|or1|o_f~0|datad
      9.981      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:1:FullAdderI|or1|o_f~0|combout
     10.210      0.229 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:2:FullAdderI|or1|o_f~0|datad
     10.365      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:2:FullAdderI|or1|o_f~0|combout
     10.589      0.224 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:3:FullAdderI|or1|o_f~0|datac
     10.876      0.287 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:3:FullAdderI|or1|o_f~0|combout
     11.104      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:4:FullAdderI|or1|o_f~0|datad
     11.259      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:4:FullAdderI|or1|o_f~0|combout
     11.486      0.227 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:5:FullAdderI|or1|o_f~0|datad
     11.641      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:5:FullAdderI|or1|o_f~0|combout
     11.869      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:6:FullAdderI|or1|o_f~0|datad
     12.024      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:6:FullAdderI|or1|o_f~0|combout
     12.250      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:7:FullAdderI|or1|o_f~0|datad
     12.405      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:7:FullAdderI|or1|o_f~0|combout
     12.632      0.227 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:8:FullAdderI|or1|o_f~0|datad
     12.787      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:8:FullAdderI|or1|o_f~0|combout
     13.013      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:9:FullAdderI|or1|o_f~0|datac
     13.300      0.287 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:9:FullAdderI|or1|o_f~0|combout
     13.526      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:10:FullAdderI|or1|o_f~0|datad
     13.681      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:10:FullAdderI|or1|o_f~0|combout
     13.905      0.224 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:11:FullAdderI|or1|o_f~0|datac
     14.192      0.287 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:11:FullAdderI|or1|o_f~0|combout
     14.418      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:12:FullAdderI|or1|o_f~0|datad
     14.573      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:12:FullAdderI|or1|o_f~0|combout
     14.996      0.423 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:13:FullAdderI|or1|o_f~0|datad
     15.151      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:13:FullAdderI|or1|o_f~0|combout
     15.380      0.229 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:14:FullAdderI|or1|o_f~0|datad
     15.535      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:14:FullAdderI|or1|o_f~0|combout
     15.761      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:15:FullAdderI|or1|o_f~0|datad
     15.916      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:15:FullAdderI|or1|o_f~0|combout
     16.127      0.211 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:16:FullAdderI|or1|o_f~0|datad
     16.282      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:16:FullAdderI|or1|o_f~0|combout
     16.493      0.211 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:17:FullAdderI|or1|o_f~0|datad
     16.648      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:17:FullAdderI|or1|o_f~0|combout
     16.858      0.210 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:18:FullAdderI|or1|o_f~0|datad
     17.013      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:18:FullAdderI|or1|o_f~0|combout
     17.439      0.426 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:19:FullAdderI|or1|o_f~0|datad
     17.594      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:19:FullAdderI|or1|o_f~0|combout
     17.822      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:20:FullAdderI|or1|o_f~0|datad
     17.977      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:20:FullAdderI|or1|o_f~0|combout
     18.205      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:21:FullAdderI|or1|o_f~0|datad
     18.360      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:21:FullAdderI|or1|o_f~0|combout
     18.588      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:22:FullAdderI|or1|o_f~0|datad
     18.743      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:22:FullAdderI|or1|o_f~0|combout
     18.969      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:23:FullAdderI|or1|o_f~0|datad
     19.124      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:23:FullAdderI|or1|o_f~0|combout
     19.349      0.225 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:24:FullAdderI|or1|o_f~0|datac
     19.636      0.287 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:24:FullAdderI|or1|o_f~0|combout
     19.863      0.227 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:25:FullAdderI|or1|o_f~0|datad
     20.018      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:25:FullAdderI|or1|o_f~0|combout
     20.245      0.227 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:26:FullAdderI|or1|o_f~0|datad
     20.400      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:26:FullAdderI|or1|o_f~0|combout
     20.628      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:27:FullAdderI|or1|o_f~0|datad
     20.783      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:27:FullAdderI|or1|o_f~0|combout
     21.011      0.228 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:28:FullAdderI|or1|o_f~0|datac
     21.298      0.287 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:28:FullAdderI|or1|o_f~0|combout
     21.524      0.226 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:29:FullAdderI|or1|o_f~0|datad
     21.679      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:29:FullAdderI|or1|o_f~0|combout
     21.906      0.227 RR    IC  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:30:FullAdderI|or1|o_f~0|datad
     22.061      0.155 RR  CELL  instALU|instAdderSub|instFullAdders|\G_NBit_FullAdder:30:FullAdderI|or1|o_f~0|combout
     22.286      0.225 RR    IC  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~11|datac
     22.556      0.270 RF  CELL  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~11|combout
     22.790      0.234 FF    IC  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~12|datac
     23.070      0.280 FF  CELL  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~12|combout
     23.296      0.226 FF    IC  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~13|datad
     23.421      0.125 FF  CELL  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~13|combout
     23.655      0.234 FF    IC  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~14|datac
     23.936      0.281 FF  CELL  instALU|instOutputMux|\G_NBit_MUX:31:MUXI|o_O~14|combout
     23.936      0.000 FF    IC  instEXMEM|\G_ALU_Reg:31:ALUDFFGI|s_Q|d
     24.040      0.104 FF  CELL  EX_MEM:instEXMEM|dffg:\G_ALU_Reg:31:ALUDFFGI|s_Q
 Data Required Path:
 Total (ns)  Incr (ns)     Type  Element
 ==========  ========= ==  ====  ===================================
     20.000     20.000           latch edge time
     23.342      3.342  R        clock network delay
     23.374      0.032           clock pessimism removed
     23.354     -0.020           clock uncertainty
     23.372      0.018     uTsu  EX_MEM:instEXMEM|dffg:\G_ALU_Reg:31:ALUDFFGI|s_Q
 Data Arrival Time  :    24.040
 Data Required Time :    23.372
 Slack              :    -0.668 (VIOLATED)
 ===================================================================
```

### Example from `src_sc/temp/timing.txt`

```
FMax: 24.21mhz Clk Constraint: 20.00ns Slack: -21.30ns

The path is given below

 ===================================================================
 From Node    : program_counter:programCounter|program_counter_dff:\NDFFGS:8:ONESCOMPI|s_Q
 To Node      : register_file:registers|dffg_n:\registerlist:3:regi|s_q[30]
 Launch Clock : iCLK
 Latch Clock  : iCLK
 Data Arrival Path:
 Total (ns)  Incr (ns)     Type  Element
 ==========  ========= ==  ====  ===================================
      0.000      0.000           launch edge time
      3.048      3.048  R        clock network delay
      3.280      0.232     uTco  program_counter:programCounter|program_counter_dff:\NDFFGS:8:ONESCOMPI|s_Q
      3.280      0.000 FF  CELL  programCounter|\NDFFGS:8:ONESCOMPI|s_Q|q
      3.603      0.323 FF    IC  s_IMemAddr[8]~2|datad
      3.728      0.125 FF  CELL  s_IMemAddr[8]~2|combout
      5.719      1.991 FF    IC  IMem|ram~45365|dataa
      6.131      0.412 FR  CELL  IMem|ram~45365|combout
      7.735      1.604 RR    IC  IMem|ram~45366|dataa
      8.152      0.417 RR  CELL  IMem|ram~45366|combout
      9.089      0.937 RR    IC  IMem|ram~45367|datad
      9.244      0.155 RR  CELL  IMem|ram~45367|combout
      9.449      0.205 RR    IC  IMem|ram~45370|datad
      9.604      0.155 RR  CELL  IMem|ram~45370|combout
     10.314      0.710 RR    IC  IMem|ram~45371|datac
     10.601      0.287 RR  CELL  IMem|ram~45371|combout
     10.967      0.366 RR    IC  IMem|ram~45382|datad
     11.106      0.139 RF  CELL  IMem|ram~45382|combout
     11.338      0.232 FF    IC  IMem|ram~45383|datac
     11.619      0.281 FF  CELL  IMem|ram~45383|combout
     11.848      0.229 FF    IC  IMem|ram~45426|datad
     11.973      0.125 FF  CELL  IMem|ram~45426|combout
     13.769      1.796 FF    IC  IMem|ram~45597|datac
     14.050      0.281 FF  CELL  IMem|ram~45597|combout
     14.275      0.225 FF    IC  IMem|ram~45768|datad
     14.400      0.125 FF  CELL  IMem|ram~45768|combout
     21.256      6.856 FF    IC  aluSrc|\G_NBit_MUX:19:MUXI|o_o~2|datab
     21.649      0.393 FF  CELL  aluSrc|\G_NBit_MUX:19:MUXI|o_o~2|combout
     22.642      0.993 FF    IC  arithmeticLogicUnit|G_SHIFTER|mux0_o|\G_NBit_MUX:12:MUXI|o_o~1|datab
     23.067      0.425 FF  CELL  arithmeticLogicUnit|G_SHIFTER|mux0_o|\G_NBit_MUX:12:MUXI|o_o~1|combout
     23.346      0.279 FF    IC  arithmeticLogicUnit|G_SHIFTER|mux2_o|\G_NBit_MUX:12:MUXI|o_o~0|datac
     23.627      0.281 FF  CELL  arithmeticLogicUnit|G_SHIFTER|mux2_o|\G_NBit_MUX:12:MUXI|o_o~0|combout
     24.284      0.657 FF    IC  arithmeticLogicUnit|G_SHIFTER|mux4_o|\G_NBit_MUX:22:MUXI|o_o~1|datac
     24.564      0.280 FF  CELL  arithmeticLogicUnit|G_SHIFTER|mux4_o|\G_NBit_MUX:22:MUXI|o_o~1|combout
     24.791      0.227 FF    IC  arithmeticLogicUnit|G_SHIFTER|mux4_o|\G_NBit_MUX:22:MUXI|o_o~3|datad
     24.916      0.125 FF  CELL  arithmeticLogicUnit|G_SHIFTER|mux4_o|\G_NBit_MUX:22:MUXI|o_o~3|combout
     25.173      0.257 FF    IC  arithmeticLogicUnit|G_MUX_RES|Mux22~1|datac
     25.454      0.281 FF  CELL  arithmeticLogicUnit|G_MUX_RES|Mux22~1|combout
     25.689      0.235 FF    IC  arithmeticLogicUnit|G_MUX_RES|Mux22~4|datac
     25.970      0.281 FF  CELL  arithmeticLogicUnit|G_MUX_RES|Mux22~4|combout
     28.780      2.810 FF    IC  DMem|ram~37860|dataa
     29.204      0.424 FF  CELL  DMem|ram~37860|combout
     29.432      0.228 FF    IC  DMem|ram~37861|datad
     29.582      0.150 FR  CELL  DMem|ram~37861|combout
     34.773      5.191 RR    IC  DMem|ram~37869|datad
     34.928      0.155 RR  CELL  DMem|ram~37869|combout
     35.132      0.204 RR    IC  DMem|ram~37870|datad
     35.287      0.155 RR  CELL  DMem|ram~37870|combout
     35.491      0.204 RR    IC  DMem|ram~37881|datad
     35.630      0.139 RF  CELL  DMem|ram~37881|combout
     35.900      0.270 FF    IC  DMem|ram~37882|datab
     36.304      0.404 FF  CELL  DMem|ram~37882|combout
     37.749      1.445 FF    IC  DMem|ram~37925|datac
     38.030      0.281 FF  CELL  DMem|ram~37925|combout
     38.256      0.226 FF    IC  DMem|ram~38096|datad
     38.381      0.125 FF  CELL  DMem|ram~38096|combout
     38.608      0.227 FF    IC  DMem|ram~38267|datad
     38.758      0.150 FR  CELL  DMem|ram~38267|combout
     38.971      0.213 RR    IC  lhUorL|\G_NBit_MUX:15:MUXI|o_o~1|datad
     39.126      0.155 RR  CELL  lhUorL|\G_NBit_MUX:15:MUXI|o_o~1|combout
     39.426      0.300 RR    IC  lbUorL|\G_NBit_MUX:7:MUXI|o_o~0|datab
     39.844      0.418 RR  CELL  lbUorL|\G_NBit_MUX:7:MUXI|o_o~0|combout
     40.049      0.205 RR    IC  lbUorL|\G_NBit_MUX:7:MUXI|o_o~1|datad
     40.204      0.155 RR  CELL  lbUorL|\G_NBit_MUX:7:MUXI|o_o~1|combout
     40.416      0.212 RR    IC  memtoReg|\G_NBit_MUX:31:MUXI|o_o~0|datad
     40.571      0.155 RR  CELL  memtoReg|\G_NBit_MUX:31:MUXI|o_o~0|combout
     41.338      0.767 RR    IC  memtoReg|\G_NBit_MUX:30:MUXI|o_o~1|datad
     41.493      0.155 RR  CELL  memtoReg|\G_NBit_MUX:30:MUXI|o_o~1|combout
     44.067      2.574 RR    IC  registers|\registerlist:3:regi|s_q[30]~feeder|datad
     44.222      0.155 RR  CELL  registers|\registerlist:3:regi|s_q[30]~feeder|combout
     44.222      0.000 RR    IC  registers|\registerlist:3:regi|s_q[30]|d
     44.309      0.087 RR  CELL  register_file:registers|dffg_n:\registerlist:3:regi|s_q[30]
 Data Required Path:
 Total (ns)  Incr (ns)     Type  Element
 ==========  ========= ==  ====  ===================================
     20.000     20.000           latch edge time
     23.006      3.006  R        clock network delay
     23.014      0.008           clock pessimism removed
     22.994     -0.020           clock uncertainty
     23.012      0.018     uTsu  register_file:registers|dffg_n:\registerlist:3:regi|s_q[30]
 Data Arrival Time  :    44.309
 Data Required Time :    23.012
 Slack              :   -21.297 (VIOLATED)
 ===================================================================
```

### Example from `src_sw/temp/timing.txt`

```
FMax: 52.86mhz Clk Constraint: 20.00ns Slack: 1.08ns

The path is given below

 ===================================================================
 From Node    : mem:IMem|altsyncram:ram_rtl_0|altsyncram_eg81:auto_generated|ram_block1a0~porta_we_reg
 To Node      : dffg_n:instPC|dffg:\G1:13:flipflop|s_Q
 Launch Clock : iCLK
 Latch Clock  : iCLK
 Data Arrival Path:
 Total (ns)  Incr (ns)     Type  Element
 ==========  ========= ==  ====  ===================================
      0.000      0.000           launch edge time
      3.465      3.465  R        clock network delay
      3.728      0.263     uTco  mem:IMem|altsyncram:ram_rtl_0|altsyncram_eg81:auto_generated|ram_block1a0~porta_we_reg
      6.577      2.849 RF  CELL  IMem|ram_rtl_0|auto_generated|ram_block1a0|portadataout[1]
      7.058      0.481 FF    IC  IMem|ram~50|datab
      7.414      0.356 FF  CELL  IMem|ram~50|combout
      8.321      0.907 FF    IC  instRegisterFile|read2|Mux25~2|datab
      8.746      0.425 FF  CELL  instRegisterFile|read2|Mux25~2|combout
      9.497      0.751 FF    IC  instRegisterFile|read2|Mux25~3|datad
      9.647      0.150 FR  CELL  instRegisterFile|read2|Mux25~3|combout
     10.902      1.255 RR    IC  instRegisterFile|read2|Mux25~4|datad
     11.057      0.155 RR  CELL  instRegisterFile|read2|Mux25~4|combout
     11.291      0.234 RR    IC  instRegisterFile|read2|Mux25~5|datab
     11.700      0.409 RF  CELL  instRegisterFile|read2|Mux25~5|combout
     11.927      0.227 FF    IC  instRegisterFile|read2|Mux25~8|datad
     12.052      0.125 FF  CELL  instRegisterFile|read2|Mux25~8|combout
     14.652      2.600 FF    IC  instRegisterFile|read2|Mux25~19|datad
     14.777      0.125 FF  CELL  instRegisterFile|read2|Mux25~19|combout
     15.062      0.285 FF    IC  instFetchUnit|zero_detector|ouput_or|o_f~3|dataa
     15.491      0.429 FR  CELL  instFetchUnit|zero_detector|ouput_or|o_f~3|combout
     16.474      0.983 RR    IC  instFetchUnit|zero_detector|ouput_or|o_f~4|datad
     16.629      0.155 RR  CELL  instFetchUnit|zero_detector|ouput_or|o_f~4|combout
     16.864      0.235 RR    IC  instFetchUnit|zero_detector|ouput_or|o_f~20|datab
     17.282      0.418 RR  CELL  instFetchUnit|zero_detector|ouput_or|o_f~20|combout
     18.146      0.864 RR    IC  instFetchUnit|s_bne_branch|datac
     18.433      0.287 RR  CELL  instFetchUnit|s_bne_branch|combout
     18.638      0.205 RR    IC  instFetchUnit|s_toBranch~16|datad
     18.793      0.155 RR  CELL  instFetchUnit|s_toBranch~16|combout
     19.220      0.427 RR    IC  instPC|\G1:8:flipflop|s_Q~0|datad
     19.375      0.155 RR  CELL  instPC|\G1:8:flipflop|s_Q~0|combout
     20.199      0.824 RR    IC  instRSTPC|\G_NBit_MUX:13:MUXI|o_o~0|datac
     20.469      0.270 RF  CELL  instRSTPC|\G_NBit_MUX:13:MUXI|o_o~0|combout
     20.702      0.233 FF    IC  instRSTPC|\G_NBit_MUX:13:MUXI|o_o~1|datac
     20.983      0.281 FF  CELL  instRSTPC|\G_NBit_MUX:13:MUXI|o_o~1|combout
     21.406      0.423 FF    IC  instRSTPC|\G_NBit_MUX:13:MUXI|o_o~2|datab
     21.831      0.425 FF  CELL  instRSTPC|\G_NBit_MUX:13:MUXI|o_o~2|combout
     21.831      0.000 FF    IC  instPC|\G1:13:flipflop|s_Q|d
     21.935      0.104 FF  CELL  dffg_n:instPC|dffg:\G1:13:flipflop|s_Q
 Data Required Path:
 Total (ns)  Incr (ns)     Type  Element
 ==========  ========= ==  ====  ===================================
     20.000     20.000           latch edge time
     22.986      2.986  R        clock network delay
     23.018      0.032           clock pessimism removed
     22.998     -0.020           clock uncertainty
     23.016      0.018     uTsu  dffg_n:instPC|dffg:\G1:13:flipflop|s_Q
 Data Arrival Time  :    21.935
 Data Required Time :    23.016
 Slack              :     1.081
 ===================================================================
```
