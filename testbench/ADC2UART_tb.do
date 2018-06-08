transcript on
if ![file isdirectory ADC2UART_top_iputf_libs] {
	file mkdir ADC2UART_top_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/dspba_library_package.vhd"                      
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/dspba_library.vhd"                              
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlog "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/altera_avalon_sc_fifo.v"                        
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/FIR_ofc_rtl_core.vhd"                           
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/FIR_ofc_ast.vhd"                                
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/FIR_ofc.vhd"                                    
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc_sim/FIR_ofc_tb.vhd"                                 
vlog "/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll_sim/UART_pll.vo"                              
vlog "/home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll_sim/lpm_pll.vo"                                 

vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/UART_pll {/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll_sim/UART_pll.vo}
vlib UART_pll
vmap UART_pll UART_pll
vlog -vlog01compat -work UART_pll +incdir+/home/srdejong/Cyclone-V-ADC-UART/UART_pll {/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/lpm_pll {/home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll_sim/lpm_pll.vo}
vlib lpm_pll
vmap lpm_pll lpm_pll
vlog -vlog01compat -work lpm_pll +incdir+/home/srdejong/Cyclone-V-ADC-UART/lpm_pll {/home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/ADC_Mux {/home/srdejong/Cyclone-V-ADC-UART/ADC_Mux/ADC_Mux.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/tenCount.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/acquireSwitch.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/signer.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/unsigner.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/flipSwitch.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/charReader.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/trigger.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/adcSync.v}
vlog -vlog01compat -work UART_pll +incdir+/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll {/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll/UART_pll_0002.v}
vlog -vlog01compat -work lpm_pll +incdir+/home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll {/home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll/lpm_pll_0002.v}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/ADC2UART_top.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/ADC_handler.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/UART_handler.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/DSP.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/bin2dec.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/signalToUART.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/waveformGenerator.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/src {/home/srdejong/Cyclone-V-ADC-UART/src/delay.sv}

vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/testbench {/home/srdejong/Cyclone-V-ADC-UART/testbench/ADC2UART_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L UART_pll -L lpm_pll -voptargs="+acc"  ADC2UART_tb

add wave *
view structure
view signals
run -all
