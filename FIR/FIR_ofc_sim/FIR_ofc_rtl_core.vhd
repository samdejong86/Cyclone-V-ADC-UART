-- ------------------------------------------------------------------------- 
-- Intel Altera DSP Builder Advanced Flow Tools Release Version 16.1
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2016 Intel Corporation.  All rights reserved.
-- Your use of  Intel  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Intel FPGA Software License Agreement,
-- Intel  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Intel and sold by
-- Intel or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from FIR_ofc_rtl_core
-- VHDL created on Tue Jul 10 12:44:49 2018


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity FIR_ofc_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(13 downto 0);  -- sfix14
        enable_i : in std_logic_vector(0 downto 0);  -- sfix1
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(35 downto 0);  -- sfix36
        clk : in std_logic;
        areset : in std_logic
    );
end FIR_ofc_rtl_core;

architecture normal of FIR_ofc_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cm0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_cm1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_cm2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_cm3_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_cm4_q : STD_LOGIC_VECTOR (18 downto 0);
    type u0_m0_wo0_cma0_a0type is array(0 to 5) of SIGNED(13 downto 0);
    signal u0_m0_wo0_cma0_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_cma0_a0 : signal is true;
    type u0_m0_wo0_cma0_c0type is array(0 to 5) of SIGNED(18 downto 0);
    signal u0_m0_wo0_cma0_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u0_m0_wo0_cma0_c0 : signal is true;
    type u0_m0_wo0_cma0_ptype is array(0 to 5) of SIGNED(32 downto 0);
    signal u0_m0_wo0_cma0_p : u0_m0_wo0_cma0_ptype;
    type u0_m0_wo0_cma0_utype is array(0 to 5) of SIGNED(35 downto 0);
    signal u0_m0_wo0_cma0_u : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_w : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_x : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_y : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_s : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal u0_m0_wo0_cma0_q : STD_LOGIC_VECTOR (35 downto 0);
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal input_valid_a : STD_LOGIC_VECTOR (0 downto 0);
    signal input_valid_b : STD_LOGIC_VECTOR (0 downto 0);
    signal input_valid_q : STD_LOGIC_VECTOR (0 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal out0_m0_wo0_assign_id3_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- u0_m0_wo0_cm4(CONSTANT,23)@0
    u0_m0_wo0_cm4_q <= "1000011010011010111";

    -- u0_m0_wo0_cm3(CONSTANT,22)@0
    u0_m0_wo0_cm3_q <= "01010100010010001";

    -- u0_m0_wo0_cm2(CONSTANT,21)@0
    u0_m0_wo0_cm2_q <= "0111111111111111111";

    -- u0_m0_wo0_cm1(CONSTANT,20)@0
    u0_m0_wo0_cm1_q <= "010101110001110101";

    -- u0_m0_wo0_cm0(CONSTANT,19)@0
    u0_m0_wo0_cm0_q <= "100000011110001101";

    -- xIn(PORTIN,2)@10

    -- d_u0_m0_wo0_compute_q_11(DELAY,31)@10 + 1
    d_u0_m0_wo0_compute_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => input_valid_q, xout => d_u0_m0_wo0_compute_q_11_q, clk => clk, aclr => areset );

    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- input_valid(LOGICAL,3)@10
    input_valid_a <= STD_LOGIC_VECTOR(xIn_v);
    input_valid_b <= STD_LOGIC_VECTOR(enable_i);
    input_valid_q <= input_valid_a and input_valid_b;

    -- u0_m0_wo0_cma0(CHAINMULTADD,24)@10 + 2
    u0_m0_wo0_cma0_p(0) <= u0_m0_wo0_cma0_a0(0) * u0_m0_wo0_cma0_c0(0);
    u0_m0_wo0_cma0_p(1) <= u0_m0_wo0_cma0_a0(1) * u0_m0_wo0_cma0_c0(1);
    u0_m0_wo0_cma0_p(2) <= u0_m0_wo0_cma0_a0(2) * u0_m0_wo0_cma0_c0(2);
    u0_m0_wo0_cma0_p(3) <= u0_m0_wo0_cma0_a0(3) * u0_m0_wo0_cma0_c0(3);
    u0_m0_wo0_cma0_p(4) <= u0_m0_wo0_cma0_a0(4) * u0_m0_wo0_cma0_c0(4);
    u0_m0_wo0_cma0_p(5) <= u0_m0_wo0_cma0_a0(5) * u0_m0_wo0_cma0_c0(5);
    u0_m0_wo0_cma0_u(0) <= RESIZE(u0_m0_wo0_cma0_p(0),36);
    u0_m0_wo0_cma0_u(1) <= RESIZE(u0_m0_wo0_cma0_p(1),36);
    u0_m0_wo0_cma0_u(2) <= RESIZE(u0_m0_wo0_cma0_p(2),36);
    u0_m0_wo0_cma0_u(3) <= RESIZE(u0_m0_wo0_cma0_p(3),36);
    u0_m0_wo0_cma0_u(4) <= RESIZE(u0_m0_wo0_cma0_p(4),36);
    u0_m0_wo0_cma0_u(5) <= RESIZE(u0_m0_wo0_cma0_p(5),36);
    u0_m0_wo0_cma0_w(0) <= u0_m0_wo0_cma0_u(0);
    u0_m0_wo0_cma0_w(1) <= u0_m0_wo0_cma0_u(1);
    u0_m0_wo0_cma0_w(2) <= u0_m0_wo0_cma0_u(2);
    u0_m0_wo0_cma0_w(3) <= u0_m0_wo0_cma0_u(3);
    u0_m0_wo0_cma0_w(4) <= u0_m0_wo0_cma0_u(4);
    u0_m0_wo0_cma0_w(5) <= u0_m0_wo0_cma0_u(5);
    u0_m0_wo0_cma0_x(0) <= u0_m0_wo0_cma0_w(0);
    u0_m0_wo0_cma0_x(1) <= u0_m0_wo0_cma0_w(1);
    u0_m0_wo0_cma0_x(2) <= u0_m0_wo0_cma0_w(2);
    u0_m0_wo0_cma0_x(3) <= u0_m0_wo0_cma0_w(3);
    u0_m0_wo0_cma0_x(4) <= u0_m0_wo0_cma0_w(4);
    u0_m0_wo0_cma0_x(5) <= u0_m0_wo0_cma0_w(5);
    u0_m0_wo0_cma0_y(0) <= u0_m0_wo0_cma0_s(1) + u0_m0_wo0_cma0_x(0);
    u0_m0_wo0_cma0_y(1) <= u0_m0_wo0_cma0_s(2) + u0_m0_wo0_cma0_x(1);
    u0_m0_wo0_cma0_y(2) <= u0_m0_wo0_cma0_s(3) + u0_m0_wo0_cma0_x(2);
    u0_m0_wo0_cma0_y(3) <= u0_m0_wo0_cma0_s(4) + u0_m0_wo0_cma0_x(3);
    u0_m0_wo0_cma0_y(4) <= u0_m0_wo0_cma0_s(5) + u0_m0_wo0_cma0_x(4);
    u0_m0_wo0_cma0_y(5) <= u0_m0_wo0_cma0_x(5);
    u0_m0_wo0_cma0_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma0_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u0_m0_wo0_cma0_a0(0) <= RESIZE(SIGNED(xIn_0),14);
                u0_m0_wo0_cma0_a0(1) <= RESIZE(SIGNED(xIn_0),14);
                u0_m0_wo0_cma0_a0(2) <= RESIZE(SIGNED(xIn_0),14);
                u0_m0_wo0_cma0_a0(3) <= RESIZE(SIGNED(xIn_0),14);
                u0_m0_wo0_cma0_a0(4) <= RESIZE(SIGNED(xIn_0),14);
                u0_m0_wo0_cma0_a0(5) <= (others => '0');
                u0_m0_wo0_cma0_c0(0) <= RESIZE(SIGNED(u0_m0_wo0_cm0_q),19);
                u0_m0_wo0_cma0_c0(1) <= RESIZE(SIGNED(u0_m0_wo0_cm1_q),19);
                u0_m0_wo0_cma0_c0(2) <= RESIZE(SIGNED(u0_m0_wo0_cm2_q),19);
                u0_m0_wo0_cma0_c0(3) <= RESIZE(SIGNED(u0_m0_wo0_cm3_q),19);
                u0_m0_wo0_cma0_c0(4) <= RESIZE(SIGNED(u0_m0_wo0_cm4_q),19);
                u0_m0_wo0_cma0_c0(5) <= (others => '0');
            END IF;
            IF (d_u0_m0_wo0_compute_q_11_q = "1") THEN
                u0_m0_wo0_cma0_s(0) <= u0_m0_wo0_cma0_y(0);
                u0_m0_wo0_cma0_s(1) <= u0_m0_wo0_cma0_y(1);
                u0_m0_wo0_cma0_s(2) <= u0_m0_wo0_cma0_y(2);
                u0_m0_wo0_cma0_s(3) <= u0_m0_wo0_cma0_y(3);
                u0_m0_wo0_cma0_s(4) <= u0_m0_wo0_cma0_y(4);
                u0_m0_wo0_cma0_s(5) <= u0_m0_wo0_cma0_y(5);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma0_s(0)(35 downto 0)), xout => u0_m0_wo0_cma0_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_qq(35 downto 0));

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq_gated_reg(REG,25)@11 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_11_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,27)@12
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id3(DELAY,29)@12
    out0_m0_wo0_assign_id3_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,30)@12 + 1
    xOut_v <= out0_m0_wo0_assign_id3_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_cma0_q;

END normal;
