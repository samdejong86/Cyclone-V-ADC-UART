set_global_assignment -entity "UART_pll" -library "lib_UART_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "UART_pll" -library "lib_UART_pll" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "UART_pll" -library "lib_UART_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_UART_pll" -name SPD_FILE [file join $::quartus(sip_path) "UART_pll.spd"]

set_global_assignment -library "lib_UART_pll" -name MISC_FILE [file join $::quartus(sip_path) "UART_pll_sim/UART_pll.vo"]
