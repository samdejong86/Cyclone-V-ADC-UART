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


vcom "/home/srdejong/Cyclone-V-ADC-UART/lpm_pll/lpm_pll_sim/lpm_pll.vho"                                
vcom "/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll_sim/UART_pll.vho"                             
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

vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll.vho}
vlib UART_pll
vmap UART_pll UART_pll
vcom -93 -work UART_pll {/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll.vhd}
vlib FIR_ofc
vmap FIR_ofc FIR_ofc
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc.vhd}
vlog -vlog01compat -work UART_pll +incdir+/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll {/home/srdejong/Cyclone-V-ADC-UART/UART_pll/UART_pll/UART_pll_0002.v}
vlog -vlog01compat -work FIR_ofc +incdir+/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/altera_avalon_sc_fifo.v}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/dspba_library_package.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/auk_dspip_math_pkg_hpfir.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/auk_dspip_avalon_streaming_controller_hpfir.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/auk_dspip_roundsat_hpfir.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/ADC_Mux/ADC_Mux.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/unsigner.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/trigger.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/tenCount.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/signer.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/flipSwitch.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/delayArray.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/charReader.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/adcSync.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/dspba_library.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/auk_dspip_lib_pkg_hpfir.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/auk_dspip_avalon_streaming_source_hpfir.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/FIR_ofc_0002_rtl_core.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/waveformGenerator.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/signalToUART.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/delayVec.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/acquireSwitch.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/auk_dspip_avalon_streaming_sink_hpfir.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/FIR_ofc_0002_ast.vhd}
vcom -93 -work FIR_ofc {/home/srdejong/Cyclone-V-ADC-UART/FIR/FIR_ofc/FIR_ofc_0002.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/UART_handler.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/DSP.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/src/ADC_handler.vhd}
vcom -93 -work work {/home/srdejong/Cyclone-V-ADC-UART/ADC2UART_top.vhd}

vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/testbench {/home/srdejong/Cyclone-V-ADC-UART/testbench/ADC2UART_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L UART_pll -L FIR_ofc -voptargs="+acc"  ADC2UART_tb

do /home/srdejong/Cyclone-V-ADC-UART/testbench/ADC2UART_tb.do
