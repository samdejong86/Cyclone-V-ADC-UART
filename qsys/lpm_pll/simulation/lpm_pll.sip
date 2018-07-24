set_global_assignment -entity "lpm_pll" -library "lib_lpm_pll" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "lpm_pll" -library "lib_lpm_pll" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "lpm_pll" -library "lib_lpm_pll" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_lpm_pll" -name SPD_FILE [file join $::quartus(sip_path) "../lpm_pll.spd"]
set_global_assignment -library "lib_lpm_pll" -name MISC_FILE [file join $::quartus(sip_path) "../../lpm_pll.qsys"]

set_global_assignment -library "lib_lpm_pll" -name MISC_FILE [file join $::quartus(sip_path) "lpm_pll.vhd"]
set_global_assignment -library "lib_lpm_pll" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lpm_pll_pll_0.vo"]
