

vlogan +v2k  "/home/srdejong/Cyclone-V-ADC-UART/qsys/UART_pll/simulation/submodules/UART_pll_UART_pll.vo"                           -work UART_pll         
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/UART_pll/simulation/UART_pll.vhd"                                                                     
vlogan +v2k  "/home/srdejong/Cyclone-V-ADC-UART/qsys/lpm_pll/simulation/submodules/lpm_pll_pll_0.vo"                                -work pll_0            
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/lpm_pll/simulation/lpm_pll.vhd"                                                                       
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/dspba_library_package.vhd"                       -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/dspba_library.vhd"                               -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/auk_dspip_math_pkg_hpfir.vhd"                    -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/auk_dspip_lib_pkg_hpfir.vhd"                     -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/auk_dspip_avalon_streaming_controller_hpfir.vhd" -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/auk_dspip_avalon_streaming_sink_hpfir.vhd"       -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/auk_dspip_avalon_streaming_source_hpfir.vhd"     -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/auk_dspip_roundsat_hpfir.vhd"                    -work fir_compiler_ii_0
vlogan +v2k  "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/altera_avalon_sc_fifo.v"                         -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/FIR_ofc_fir_compiler_ii_0_rtl_core.vhd"          -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/FIR_ofc_fir_compiler_ii_0_ast.vhd"               -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/FIR_ofc_fir_compiler_ii_0.vhd"                   -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/submodules/FIR_ofc_fir_compiler_ii_0_tb.vhd"                -work fir_compiler_ii_0
vhdlan -xlrm "/home/srdejong/Cyclone-V-ADC-UART/qsys/FIR_ofc/simulation/FIR_ofc.vhd"                                                                       
