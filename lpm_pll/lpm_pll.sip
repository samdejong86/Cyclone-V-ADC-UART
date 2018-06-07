set_global_assignment -entity "lpm_pll" -library "lib_lpm_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "lpm_pll" -library "lib_lpm_pll" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "lpm_pll" -library "lib_lpm_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_lpm_pll" -name SPD_FILE [file join $::quartus(sip_path) "lpm_pll.spd"]

set_global_assignment -library "lib_lpm_pll" -name MISC_FILE [file join $::quartus(sip_path) "lpm_pll_sim/lpm_pll.vo"]
