-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
-- 2. Entity Declaration 
----------------------------------------------------------------
entity top_level is
    Port ( clk                           : in  STD_LOGIC;
           reset_n                       : in  STD_LOGIC;
			  button 							  : in  STD_LOGIC;
			  SW                            : in  STD_LOGIC_VECTOR (9 downto 0);
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
          );
           
end top_level;

-- 3. Architecture
----------------------------------------------------------------
architecture Behavioral of top_level is

-- Intermediate Signals --
Signal Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');   
Signal DP_in, Blank:  STD_LOGIC_VECTOR (5 downto 0);
Signal switch_inputs: STD_LOGIC_VECTOR (12 downto 0);
Signal bcd:           STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal in1, in2, in3, in4, mux_out: STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal s: STD_LOGIC_VECTOR(1 DOWNTO 0);
Signal D, Q: STD_LOGIC_VECTOR (7 downto 0);
Signal EN: STD_LOGIC; 

-- Declarations --
Component SevenSegment is
    Port( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
          DP_in,Blank                                           : in  STD_LOGIC_VECTOR (5 downto 0)
			);
End Component ;

Component binary_bcd is
   PORT(
      clk     : IN  STD_LOGIC;                      --system clock
      reset_n : IN  STD_LOGIC;                      --active low asynchronus reset_n (0 = reset, 1 = operate)
      binary  : IN  STD_LOGIC_VECTOR(12 DOWNTO 0);  --binary number to convert
      bcd     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)   --resulting binary coded decimal number
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
			D     				: in  std_logic_vector(7 downto 0); -- output of synchronizer 
			EN, reset_n, clk    : in  std_logic;							-- EN is ouput of debounce 				  
			Q     				: out std_logic_vector(7 downto 0)  -- input to mux 
			);
END Component;

-- Operation ---
begin
   Num_Hex0 <= mux_out(3 downto 0); --divide up 15 bits into 4 bit groups (easier to conver to hex) 
   Num_Hex1 <= mux_out(7 downto 4);
   Num_Hex2 <= mux_out(11 downto 8);
   Num_Hex3 <= mux_out(15 downto 12);
   Num_Hex4 <= "0000"; -- leave unaltered 
   Num_Hex5 <= "0000";   
   DP_in    <= "000000"; -- position of the decimal point in the display (1=LED on,0=LED off)
   Blank    <= "110000"; -- blank the 2 MSB 7-segment displays (1=7-seg display off, 0=7-seg display on)
	in4 <= "0101101001011010"; -- in4 of mux will always be 5A5A 
  	
       
-- Instantiations --		 
SevenSegment_ins: SevenSegment  

                  PORT MAP( Num_Hex0 => Num_Hex0,
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
                                     
 
LEDR(9 downto 0) <=SW(9 downto 0); -- gives visual display of the switch inputs to the LEDs on board
switch_inputs <= "00000" & SW(7 downto 0); -- switches that are associated with bits 

binary_bcd_ins: binary_bcd  
                             
   PORT MAP(
      clk      => clk,                          
      reset_n  => reset_n,                                 
      binary   => switch_inputs,    
      bcd      => bcd         
      );
		
in2 <= "000" & switch_inputs;
s <= SW(9 downto 8); 
in3 <= "00000000" & Q; -- Extend signal to 16 bits 

MUX4TO1_ins: MUX4TO1
    
	 PORT MAP (
		in1 		=>  bcd,  
		in2		=>  in2,
		in3      =>  in3,
		in4      =>  in4,
		s 			=>  s,
		mux_out  =>  mux_out
		);

D <= SW(7 downto 0);

stored_value_ins: stored_value 

	Port MAP ( 
		 D  => D,
		 EN => button, 
		 reset_n => reset_n,
		 clk => clk,    				  
		 Q => Q    				
		 );
		
end Behavioral;