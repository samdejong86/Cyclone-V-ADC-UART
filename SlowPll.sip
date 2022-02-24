set_global_assignment -entity "SlowPll" -library "lib_SlowPll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "SlowPll" -library "lib_SlowPll" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "SlowPll" -library "lib_SlowPll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_SlowPll" -name SPD_FILE [file join $::quartus(sip_path) "SlowPll.spd"]

set_global_assignment -library "lib_SlowPll" -name MISC_FILE [file join $::quartus(sip_path) "SlowPll_sim/SlowPll.vo"]
