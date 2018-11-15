

library IEEE;
use	IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;
use ieee.math_real.all;



entity ADC2UART_tb is
end entity;

--my custom modules
library work;
use work.my_types_pkg.all;

architecture tb of ADC2UART_tb is
		signal clk_50					: std_logic :='1';
		
		signal delaySwitch				: std_logic:='0';
		signal triggerSlopeSwitch			: std_logic:='0';
		signal triggerSwitch				: std_logic:='0';
		
		signal AD_SCLK					: std_logic;
		signal AD_SDIO					: std_logic;
		
		signal ADA_DCO					: std_logic :='1';
		signal ADA_OE					: std_logic;
		signal ADA_SPI_CS				: std_logic;
		
		signal ADB_DCO					: std_logic :='1';
		signal ADB_OE					: std_logic;
		signal ADB_SPI_CS				: std_logic;
		
		signal ADC_DA					: unsigned 			(13 DOWNTO 0);
		signal ADC_DB					: unsigned 			(13 DOWNTO 0);
		
		signal FPGA_CLK_A_N			: std_logic;
		signal FPGA_CLK_A_P			: std_logic;
		signal FPGA_CLK_B_N			: std_logic;
		signal FPGA_CLK_B_P			: std_logic;
		
		signal led						: unsigned (3 DOWNTO 0);
		
		signal UART_RX					: std_logic:='1';
		signal UART_TX					: std_logic;
		
		signal counter 		: integer :=0;
		signal UARTcounter 		: integer :=0;
		--signal UARTclk		: std_logic:=0;
		
		constant Tpw_clk : time := 10 ns;
		constant dco_clk : time := 12.5 ns;
		constant UART_clk: time := 500 ns;
		
		signal gpioTrig : std_logic :='0';

                signal charToSend : std_logic_vector(7 downto 0) := "00000000";  --default is blank

		signal rand_num : integer := 0;
                                                                                                                                          
                
begin

	process
    		variable seed1, seed2: positive;               -- seed values for random generator
   		variable rand: real;   -- random real-number value in range 0 to 1.0  
    		variable range_of_rand : real := 10.0;    -- the range of random values created will be 0 to +1000.
	begin
    		uniform(seed1, seed2, rand);   -- generate random number
    		rand_num <= integer(rand*range_of_rand);  -- rescale to 0..1000, convert integer part 
	    	wait for 10 ns;
	end process;



	clock_gen : process is
		begin
			clk_50 <= '0' after Tpw_clk, '1' after 2*Tpw_clk;
			Wait for 2*Tpw_clk;
	end process clock_gen;

	UARTclock_gen : process is
		begin
			--UARTclk <= '0' after UART_clk, '1' after 2*UART_clk;
			UARTcounter <=UARTcounter+1;
			Wait for 2*UART_clk;
	end process UARTclock_gen;


	dco_gen : process is
		begin
			ADA_DCO <= '0' after dco_clk, '1' after 2*dco_clk;
			ADB_DCO <= '0' after dco_clk, '1' after 2*dco_clk;
			counter<=counter+1;
			Wait for 2*dco_clk;
	end process dco_gen;

	testbench : entity work.ADC2UART_top PORT MAP (
		clk_50	 =>	clk_50,
		delaySwitch	 =>	delaySwitch,
		triggerSlopeSwitch	 =>	triggerSlopeSwitch,
		triggerSwitch	 =>	triggerSwitch,
		AD_SCLK	 =>	AD_SCLK,
		AD_SDIO	 =>	AD_SDIO,
		ADA_DCO	 =>	ADA_DCO,
		ADA_OE	 =>	ADA_OE,
		ADA_SPI_CS	 =>	ADA_SPI_CS,
		ADB_DCO	 =>	ADB_DCO,
		ADB_OE	 =>	ADB_OE,
		ADB_SPI_CS	 =>	ADB_SPI_CS,
		ADC_DA	 =>	ADC_DA,
		ADC_DB	 =>	ADC_DB,
		FPGA_CLK_A_N	 =>	FPGA_CLK_A_N,
		FPGA_CLK_A_P	 =>	FPGA_CLK_A_P,
		FPGA_CLK_B_N	 =>	FPGA_CLK_B_N,
		FPGA_CLK_B_P	 =>	FPGA_CLK_B_P,
		led	 =>	led,
		UART_RX	 =>	UART_RX,
		UART_TX	 =>	UART_TX,
		gpioTrigger => gpioTrig
	);



	sendChar: process is
	--variable char  : std_logic_vector(7 downto 0) := "01110111";  -- 'w'
	variable CHARctr : natural range 0 to 9:=0;
	begin
		if UARTcounter = 100 then
			UART_RX<='0';
		elsif UARTcounter > 100 and UARTcounter <109 then
			UART_RX<=charToSend(CHARctr);
			CHARctr:=CHARctr+1;
		else
			UART_RX<='1';
			CHARctr:=0;
		end if;
		wait for 2*UART_clk;
	end process sendChar;
	





	ADC_B_gen : process is
	begin
                if counter mod 80 =0 then
                ADC_DB<=to_unsigned(13843, 14);
                elsif counter mod 80 =1 then
                ADC_DB<=to_unsigned(11721, 14);
                elsif counter mod 80 =2 then
                ADC_DB<=to_unsigned(9367, 14);
                elsif counter mod 80 =3 then
                ADC_DB<=to_unsigned(8148, 14);
                elsif counter mod 80 =4 then
                ADC_DB<=to_unsigned(7690, 14);
                elsif counter mod 80 =5 then
                ADC_DB<=to_unsigned(7545, 14);
                elsif counter mod 80 =6 then
                ADC_DB<=to_unsigned(7456, 14);
                elsif counter mod 80 =7 then
                ADC_DB<=to_unsigned(7443, 14);
                elsif counter mod 80 =8 then
                ADC_DB<=to_unsigned(7439, 14);
                elsif counter mod 80 =9 then
                ADC_DB<=to_unsigned(7477, 14)+to_unsigned(rand_num,14);
                elsif counter mod 80 =10 then
                ADC_DB<=to_unsigned(7495, 14);
                elsif counter mod 80 =11 then
                ADC_DB<=to_unsigned(7518, 14);
                elsif counter mod 80 =12 then
                ADC_DB<=to_unsigned(7561, 14);
                elsif counter mod 80 =13 then
                ADC_DB<=to_unsigned(7591, 14);
                elsif counter mod 80 =14 then
                ADC_DB<=to_unsigned(7636, 14);
                elsif counter mod 80 =15 then
                ADC_DB<=to_unsigned(7655, 14);
                elsif counter mod 80 =16 then
                ADC_DB<=to_unsigned(7652, 14);
                elsif counter mod 80 =17 then
                ADC_DB<=to_unsigned(7700, 14);
                elsif counter mod 80 =18 then
                ADC_DB<=to_unsigned(7711, 14);
                elsif counter mod 80 =19 then
                ADC_DB<=to_unsigned(7727, 14);
                elsif counter mod 80 =20 then
                ADC_DB<=to_unsigned(7749, 14);
                elsif counter mod 80 =21 then
                ADC_DB<=to_unsigned(7770, 14);
                elsif counter mod 80 =22 then
                ADC_DB<=to_unsigned(7799, 14);
                elsif counter mod 80 =23 then
                ADC_DB<=to_unsigned(7780, 14);
                elsif counter mod 80 =24 then
                ADC_DB<=to_unsigned(7812, 14);
                elsif counter mod 80 =25 then
                ADC_DB<=to_unsigned(7828, 14);
                elsif counter mod 80 =26 then
                ADC_DB<=to_unsigned(7841, 14);
                elsif counter mod 80 =27 then
                ADC_DB<=to_unsigned(7848, 14);
                elsif counter mod 80 =28 then
                ADC_DB<=to_unsigned(7872, 14);
                elsif counter mod 80 =29 then
                ADC_DB<=to_unsigned(7887, 14);
                elsif counter mod 80 =30 then
                ADC_DB<=to_unsigned(7894, 14);
                elsif counter mod 80 =31 then
                ADC_DB<=to_unsigned(7916, 14);
                elsif counter mod 80 =32 then
                ADC_DB<=to_unsigned(7919, 14);
                elsif counter mod 80 =33 then
                ADC_DB<=to_unsigned(7931, 14);
                elsif counter mod 80 =34 then
                ADC_DB<=to_unsigned(7945, 14);
                elsif counter mod 80 =35 then
                ADC_DB<=to_unsigned(7959, 14)+to_unsigned(rand_num,14);
                elsif counter mod 80 =36 then
                ADC_DB<=to_unsigned(7948, 14);
                elsif counter mod 80 =37 then
                ADC_DB<=to_unsigned(8003, 14);
                elsif counter mod 80 =38 then
                ADC_DB<=to_unsigned(7998, 14);
                elsif counter mod 80 =39 then
                ADC_DB<=to_unsigned(8006, 14);
                elsif counter mod 80 =40 then
                ADC_DB<=to_unsigned(8020, 14);
                elsif counter mod 80 =41 then
                ADC_DB<=to_unsigned(8040, 14);
                elsif counter mod 80 =42 then
                ADC_DB<=to_unsigned(8043, 14);
                elsif counter mod 80 =43 then
                ADC_DB<=to_unsigned(8060, 14);
                elsif counter mod 80 =44 then
                ADC_DB<=to_unsigned(8037, 14);
                elsif counter mod 80 =45 then
                ADC_DB<=to_unsigned(8064, 14);
                elsif counter mod 80 =46 then
                ADC_DB<=to_unsigned(8048, 14);
                elsif counter mod 80 =47 then
                ADC_DB<=to_unsigned(8052, 14);
                elsif counter mod 80 =48 then
                ADC_DB<=to_unsigned(8055, 14);
                elsif counter mod 80 =49 then
                ADC_DB<=to_unsigned(8058, 14);
                elsif counter mod 80 =50 then
                ADC_DB<=to_unsigned(8055, 14);
                elsif counter mod 80 =51 then
                ADC_DB<=to_unsigned(8055, 14);
                elsif counter mod 80 =52 then
                ADC_DB<=to_unsigned(8048, 14);
                elsif counter mod 80 =53 then
                ADC_DB<=to_unsigned(8053, 14)+to_unsigned(rand_num,14);
                elsif counter mod 80 =54 then
                ADC_DB<=to_unsigned(8067, 14);
                elsif counter mod 80 =55 then
                ADC_DB<=to_unsigned(8058, 14);
                elsif counter mod 80 =56 then
                ADC_DB<=to_unsigned(8051, 14);
                elsif counter mod 80 =57 then
                ADC_DB<=to_unsigned(8070, 14);
                elsif counter mod 80 =58 then
                ADC_DB<=to_unsigned(8064, 14);
                elsif counter mod 80 =59 then
                ADC_DB<=to_unsigned(8050, 14);
                elsif counter mod 80 =60 then
                ADC_DB<=to_unsigned(8046, 14);
                elsif counter mod 80 =61 then
                ADC_DB<=to_unsigned(8057, 14);
                elsif counter mod 80 =62 then
                ADC_DB<=to_unsigned(8076, 14);
                elsif counter mod 80 =63 then
                ADC_DB<=to_unsigned(8048, 14);
                elsif counter mod 80 =64 then
                ADC_DB<=to_unsigned(8055, 14);
                elsif counter mod 80 =65 then
                ADC_DB<=to_unsigned(8044, 14);
                elsif counter mod 80 =66 then
                ADC_DB<=to_unsigned(8055, 14);
                elsif counter mod 80 =67 then
                ADC_DB<=to_unsigned(8057, 14);
                elsif counter mod 80 =68 then
                ADC_DB<=to_unsigned(8059, 14);
                elsif counter mod 80 =69 then
                ADC_DB<=to_unsigned(8045, 14);
                elsif counter mod 80 =70 then
                ADC_DB<=to_unsigned(8052, 14);
                elsif counter mod 80 =71 then
                ADC_DB<=to_unsigned(8069, 14);
                elsif counter mod 80 =72 then
                ADC_DB<=to_unsigned(8061, 14);
                elsif counter mod 80 =73 then
                ADC_DB<=to_unsigned(8060, 14);
                elsif counter mod 80 =74 then
                ADC_DB<=to_unsigned(8053, 14);
                elsif counter mod 80 =75 then
                ADC_DB<=to_unsigned(8065, 14);
                elsif counter mod 80 =76 then
                ADC_DB<=to_unsigned(8064, 14);
                elsif counter mod 80 =77 then
                ADC_DB<=to_unsigned(8063, 14);
                elsif counter mod 80 =78 then
                ADC_DB<=to_unsigned(8064, 14);
                elsif counter mod 80 =79 then
                ADC_DB<=to_unsigned(11004, 14);
		end if;
		
		Wait for 2*dco_clk;

	end process ADC_B_gen;

	ADC_A_gen : process is
	variable ADCctr : natural range 0 to 40:=0;
	begin
		if ADC_DB < 7600 and ADCctr=0 then
			ADCctr:=1;			
		end if;
	
		if ADCctr>=1 and ADCctr<25 then
			--ADC_DA<=to_unsigned(16383, 14);
			gpioTrig<='1';
			ADCctr:=ADCctr+1;
		else 
			--ADC_DA<=to_unsigned(0,14);
			gpioTrig<='0';
			ADCctr:=0;
		end if;

		--if ADCctr>=20 and ADCctr>40  then
			--ADC_DA<=to_unsigned(16383, 14);
		--else
			--ADC_DA<=to_unsigned(0,14);
		--end if;


		Wait for 2*dco_clk;
	end process ADC_A_gen;




end architecture;
		
