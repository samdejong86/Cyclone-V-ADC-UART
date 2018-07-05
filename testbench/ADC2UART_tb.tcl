

vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll.vhd
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll_sim/lpm_pll.vho
vcom -reportprogress 300 -work work /home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/FIR_ofc.vhd

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




run 10000ns