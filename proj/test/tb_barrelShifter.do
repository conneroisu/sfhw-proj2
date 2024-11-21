onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_barrelshifter/s_data
add wave -noupdate /tb_barrelshifter/s_O
add wave -noupdate /tb_barrelshifter/s_debug
add wave -noupdate /tb_barrelshifter/halfClk
add wave -noupdate -radix decimal /tb_barrelshifter/s_data
add wave -noupdate -radix decimal /tb_barrelshifter/s_O
add wave -noupdate -radix decimal /tb_barrelshifter/s_debug
add wave -noupdate /tb_barrelshifter/halfClk
add wave -noupdate /tb_barrelshifter/N
add wave -noupdate /tb_barrelshifter/s_shamt
add wave -noupdate /tb_barrelshifter/s_leftOrRight
add wave -noupdate /tb_barrelshifter/s_shiftType
add wave -noupdate /tb_barrelshifter/ClkHelper
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2048 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 271
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1548 ns} {2716 ns}
