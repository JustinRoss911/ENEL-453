-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
-- 2. Entity Declaration 
----------------------------------------------------------------
entity top_level is
    Port ( clk                           : in  std_logic;
           reset_n                       : in  std_logic;
			  button	 							  : in  std_logic;
			  SW                            : in  std_logic_vector (9 downto 0);
           LEDR                          : out std_logic_vector (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out std_logic_vector (7 downto 0)
          );
           
end top_level;

-- 3. Architecture
----------------------------------------------------------------
architecture Behavioral of top_level is

-- intermediate Signals --
Signal Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 : std_logic_vector (3 downto 0):= (others=>'0');   
Signal in1, in2, in3, in4, mux_out: std_logic_vector(15 DOWNTO 0);
Signal dp1, dp2, dp3, dp4, dp_out: std_logic_vector(5 DOWNTO 0);

Signal DP_in, Blank:		std_logic_vector (5 downto 0);
Signal switch_inputs:	std_logic_vector (12 downto 0);
Signal bcd:					std_logic_vector(15 DOWNTO 0);
Signal binary: std_logic_vector (12 downto 0);
Signal bcd2:					std_logic_vector(15 DOWNTO 0);
Signal binary2: std_logic_vector (12 downto 0);


Signal G, A:			std_logic_vector(9 downto 0);
Signal Q, D:			std_logic_vector(21 downto 0);
Signal result, EN:	std_logic;
Signal s:				std_logic_vector(1 downto 0);

Signal voltage, distance : STD_LOGIC_VECTOR (12 downto 0); -- Voltage in milli-volts
Signal ADC_raw, ADC_out: STD_LOGIC_VECTOR (11 downto 0); -- distance in 10^-4 cm (e.g. if distance = 33 cm, then 3300 is the value)

--Signal clk_freq: INTEGER; --system clock frequency in Hz
--Signal stable_time: INTEGER;

-- Declarations --
Component SevenSegment is
    Port( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  std_logic_vector (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out std_logic_vector (7 downto 0);
          DP_in,Blank                                           : in  std_logic_vector (5 downto 0)
			);
End Component ;

Component binary_bcd is
   PORT(
      clk     : in  std_logic;                      --system clock
      reset_n : in  std_logic;                      --active low asynchronus reset_n (0 = reset, 1 = operate)
      binary  : in  std_logic_vector(12 DOWNTO 0);  --binary number to convert
      bcd     : out std_logic_vector(15 DOWNTO 0)   --resulting binary coded decimal number
		);           
END Component;

Component MUX4TO1 is 
   Port ( 
		 in1     : in  std_logic_vector(15 downto 0); -- in1 = binary (hex)
       in2     : in  std_logic_vector(15 downto 0); -- in2 = decimal 
		 in3     : in  std_logic_vector(15 downto 0); -- in3 = stored value 
		 in4     : in  std_logic_vector(15 downto 0); -- in4 = 5A5A
       s       : in  std_logic_vector(1  downto 0); -- Switches that toggles between mode
       mux_out : out std_logic_vector(15 downto 0)	 -- output bits 
		 );
END Component;

Component stored_value is 
	Port ( 
			D     				: in  std_logic_vector(21 downto 0); -- output of synchronizer 
			EN, reset_n, clk  : in  std_logic;							-- EN is ouput of debounce 				  
			Q     				: out std_logic_vector(21 downto 0)  -- input to mux 
			);
END Component;

Component synchronizer is
	port	(
			A: 	in		std_logic_vector(9 downto 0); -- switch signals
			CLK, reset_n:	in		std_logic;							--
			G:		out	std_logic_vector(9 downto 0)	-- synched swtich signals / output of synchronizer
			);
end component;

Component debounce is
GENERIC(
    clk_freq    : INTEGER := 50_000_000;  --system clock frequency in Hz
    stable_time : INTEGER := 30);
    PORT(
        clk     : IN  STD_LOGIC;  --input clock
        reset_n : IN  STD_LOGIC;  --asynchronous active low reset
        button  : IN  STD_LOGIC;  --input signal to be debounced
        result  : OUT STD_LOGIC   --debounced signal
        );
end component;

Component ADC_Data is
	PORT(clk      : in STD_LOGIC;
	     reset_n  : in STD_LOGIC; -- active-low
	     voltage  : out STD_LOGIC_VECTOR (12 downto 0); -- Voltage in milli-volts
		  distance : out STD_LOGIC_VECTOR (12 downto 0); -- distance in 10^-4 cm (e.g. if distance = 33 cm, then 3300 is the value)
		  ADC_raw  : out STD_LOGIC_VECTOR (11 downto 0); -- the latest 12-bit ADC value
        ADC_out  : out STD_LOGIC_VECTOR (11 downto 0)  -- moving average of ADC value, over 256 samples,
         );                                              -- number of samples defined by the averager module
End component;

Component DPmux is
port ( dp1 	  : in  std_logic_vector(5 downto 0);
		 dp2	  : in  std_logic_vector(5 downto 0);
		 dp3	  : in  std_logic_vector(5 downto 0);
		 dp4	  : in  std_logic_vector(5 downto 0);
		 s      : in  std_logic_vector(1 downto 0); -- Switches that toggles between mode
       dp_out : out std_logic_vector(5 downto 0)  -- output bits 
      );
End component;

Component BlankZero is
port ( Q      : in  std_logic_vector(15 downto 0); --only needs this portion of the output of storedvalue
		 s      : in  std_logic_vector(1 downto 0);
		 blank  : out std_logic_vector(5 downto 0)
		);
End component;

-- Operation ---
begin
   Num_Hex0 <= Q(3 downto 0); --divide up 15 bits into 4 bit groups (easier to conver to hex) 
   Num_Hex1 <= Q(7 downto 4);
   Num_Hex2 <= Q(11 downto 8);
   Num_Hex3 <= Q(15 downto 12);
   Num_Hex4 <= "0000"; -- leave unaltered 
   Num_Hex5 <= "0000";   
   DP_in    <= Q(21 downto 16); -- position of the decimal point in the display (1=LED on,0=LED off)
   --Blank    <= blank; -- Need to change this to blank inactive LEDs for modes 3 and 4 by
		--Jade: by defult i think blank should be set to 1 unless the hex5 has a value other then 1
		-- we do a if else statements for each hex display starting with hex 5 then hex4 then hex3 and so on
  	
       
-- instantiations --	
BlankZero_ins: BlankZero  
	PORT MAP(
		s => s,	-- only activates BlankZero if in state 2 or 3
		Q => Q(15 downto 0), -- we only care about the numbers going to be displayed
		Blank => Blank -- will feed the new output to Sevensegment display
		);
		
SevenSegment_ins: SevenSegment  
	PORT MAP(
		Num_Hex0 => Num_Hex0,
      Num_Hex1 => Num_Hex1,
      Num_Hex2 => Num_Hex2,
      Num_Hex3 => Num_Hex3,
      Num_Hex4 => Num_Hex4,
      Num_Hex5 => Num_Hex5,
      Hex0     => Hex0,
      Hex1     => Hex1,
      Hex2     => Hex2,
      Hex3     => Hex3,
      Hex4     => Hex4,
      Hex5     => Hex5,
      DP_in    => DP_in,
		Blank    => Blank
		);
                                     
 
LEDR(9 downto 0) <= SW(9 downto 0); -- gives visual display of the switch inputs to the LEDs on board
switch_inputs 	  <= "00000" & G(7 downto 0); -- switches that are associated with bits 
binary <= distance;

binary_bcd_ins: binary_bcd                       
   PORT MAP(
      clk      => clk,                          
      reset_n  => reset_n,                                 
      binary   => binary,    
      bcd      => bcd         
      );
	
binary2 <= voltage;

binary_bcd_ins2: binary_bcd                       
   PORT MAP(
      clk      => clk,                          
      reset_n  => reset_n,                                 
      binary   => binary2,    
      bcd      => bcd2  
	);

in1 <= "00000000" & G(7 downto 0); -- Hex output
in2 <= bcd; -- decimal distance 
in3 <= bcd2;
in4 <= "0000" &  ADC_out;
s 	<= G(9 downto 8); 

MUX4TO1_ins: MUX4TO1
	 PORT MAP (
		in1 		=>  in1,  -- hex switch outputs
		in2		=>  in2,	 -- decimal distance
		in3      =>  in3,  -- decimal voltage
		in4      =>  in4,  -- hex moving average 
		s 			=>  s,
		mux_out  =>  mux_out
		);

D <= dp_out & mux_out;
EN <= result;

stored_value_ins: stored_value 
	Port MAP ( 
		 D  		=> D,
		 EN 		=> EN, 
		 reset_n => reset_n,
		 clk		=> clk,    				  
		 Q 		=> Q    				
		 );
		 
A <= SW(9 downto 0);
	
synchronizer_ins: synchronizer
	port map(
			A 		=> A,
			clk 	=> clk,
			G		=> G,
			reset_n => reset_n
			);
			

debounce_ins : debounce
   GENERIC map(
    clk_freq    => 50_000_000,  --system clock frequency in Hz
    stable_time => 30)
    port map(
       clk     => clk,
        button  => button,
        reset_n => reset_n,
        result  => result
        );
		
ADC_Data_ins: ADC_Data
	port map (
		  clk    => clk,  
	     reset_n => reset_n,
	     voltage => voltage, 
		  distance => distance,
		  ADC_raw  => ADC_raw,
        ADC_out  => ADC_out
         );  
			
dp1 <= "000000";
dp2 <= "000100";
dp3 <= "001000";
dp4 <= "000000";
	
DPmux_ins: DPmux
	 PORT MAP (
		dp1 		=>  dp1,  
		dp2		=>  dp2,	 
		dp3      =>  dp3,  
		dp4      =>  dp4,  
		s 			=>  s,
		dp_out  =>  dp_out
		);

end Behavioral;