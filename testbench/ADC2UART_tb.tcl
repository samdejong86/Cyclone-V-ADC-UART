
#cd /home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/

#source FIR_ofc_msim.tcl

#quit -sim

#cd /home/srdejong/Cyclone-V-ADC-UART/simulation/modelsim/


vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/testbench/lpm_pll_sim.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/testbench/UART_pll_sim.vhd

#vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/FIR_ofc.vhd

vmap uart_pll rtl_work
vmap lpm_pll rtl_work
vmap fir_ofc rtl_work


vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/delayArray.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/unsigner.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/signer.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/waveformGenerator.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/DSP.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/delayVec.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/trigger.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/ADC_handler.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/signalToUART.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/flipSwitch.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/acquireSwitch.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/charReader.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/UART_handler.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/adcSync.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/src/tenCount.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/ADC2UART_top.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/testbench/ADC2UART_tb.vhd

vsim -i -l msim_transcript work.adc2uart_tb


add wave -position end  sim:/adc2uart_tb/clk_50
add wave -position end  sim:/adc2uart_tb/ADA_DCO
add wave -position end  sim:/adc2uart_tb/ADB_DCO

add wave -position end  sim:/adc2uart_tb/ADC_DA
add wave -position end  sim:/adc2uart_tb/ADC_DB

#UART:
add wave -position end  sim:/adc2uart_tb/UART_RX
add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/delayUART

add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/clk
add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/UART_RX
add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/char
add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/newChar
add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/intermediateChar
add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/counter

#pll
#add wave -position end  sim:/adc2uart_tb/testbench/adc_pll_inst/refclk
#add wave -position end  sim:/adc2uart_tb/testbench/adc_pll_inst/outclk_0
#add wave -position end  sim:/adc2uart_tb/testbench/adc_pll_inst/outclk_1
#add wave -position end  sim:/adc2uart_tb/testbench/adc_pll_inst/outclk_2
#add wave -position end  sim:/adc2uart_tb/testbench/adc_pll_inst/outclk_3

#add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/slowPll/refclk
#add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/slowPll/rst
#add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/slowPll/outclk_0

#FIR
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/clk
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/reset_n
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_sink_data
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_sink_valid
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_sink_ready
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_sink_error
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_source_data
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_source_valid
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_source_ready
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/ast_source_error
add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/coeff_in_read_sig



run 10000ns