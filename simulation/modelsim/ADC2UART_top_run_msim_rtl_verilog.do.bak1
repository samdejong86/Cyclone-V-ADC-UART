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


vlog "/home/srdejong/Cyclone-V-ADC-UART/lpm_pll_sim/lpm_pll.vo"                                     
vlog "/home/srdejong/Cyclone-V-ADC-UART/SlowPll_sim/SlowPll.vo"                                     
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/dspba_library_package.vhd"                      
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/dspba_library.vhd"                              
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlog "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/altera_avalon_sc_fifo.v"                        
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/FIR_ofc_rtl_core.vhd"                           
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/FIR_ofc_ast.vhd"                                
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/FIR_ofc.vhd"                                    
vcom "/home/srdejong/Cyclone-V-ADC-UART/FIR_ofc_sim/FIR_ofc_tb.vhd"                                 

vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/signer.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/trigger.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/acquireSwitch.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/trigOut.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART/oneChannelMux {/home/srdejong/Cyclone-V-ADC-UART/oneChannelMux/oneChannelMux.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/trigger_Mux.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/trigLevel.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/TrigLevelMux.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/DelayMux.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/readADC.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/unsigner.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/charReader.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/tenCount.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/flipSwitch.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/flipflop.v}
vlog -vlog01compat -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/controlChars.v}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/bin2dec.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/signalToUART.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/waveformGenerator.sv}
vlog -sv -work work +incdir+/home/srdejong/Cyclone-V-ADC-UART {/home/srdejong/Cyclone-V-ADC-UART/delay.sv}

