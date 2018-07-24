set_global_assignment -entity "UART_pll" -library "lib_UART_pll" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "UART_pll" -library "lib_UART_pll" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "UART_pll" -library "lib_UART_pll" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_UART_pll" -name SPD_FILE [file join $::quartus(sip_path) "../UART_pll.spd"]
set_global_assignment -library "lib_UART_pll" -name MISC_FILE [file join $::quartus(sip_path) "../../UART_pll.qsys"]

set_global_assignment -library "lib_UART_pll" -name MISC_FILE [file join $::quartus(sip_path) "UART_pll.vhd"]
set_global_assignment -library "lib_UART_pll" -name MISC_FILE [file join $::quartus(sip_path) "submodules/UART_pll_UART_pll.vo"]
