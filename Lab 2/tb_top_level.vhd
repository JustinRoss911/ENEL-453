--testbench code for top level 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_stored_value is
	Component top_level is 
    Port ( clk                           : in  std_logic;
           reset_n                       : in  std_logic;
			  button 							  : in  std_logic;
			  SW                            : in  std_logic_vector (9 downto 0);
           LEDR                          : out std_logic_vector (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out std_logic_vector (7 downto 0)
          );
	END Component;
	
	Signal reset_n, button : std_logic;
	Signal SW, LEDR: std_logic_vector(9 downto 0); 
	
	Signal clk : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : top_level
    port map (clk     => clk,
              reset_n => reset_n,
              button  => button,
				  SW      => SW,
				  LEDR    => LEDR,
				  HEX0    => HEX0,
				  HEX1    => HEX1,
				  HEX2    => HEX2,
				  HEX3    => HEX3,
				  HEX4    => HEX4,
				  HEX5    => HEX5);
				  
				  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
		  reset_n <= '1'; -- operating normaly
		  button <= '0';	-- do not store current value 
		  SW <= "000000000"; -- binary mode, input 0 

        wait for 2 * TbPeriod;
		  
		  -- Start tests 
		  
		  -- 1. binary operation 
		  
		  SW <= "001111111"; -- binary mode, expect 127 on LEDs 
		  -- Expecting....
		  -- HEX0 = 0000110 (1)
		  -- HEX1 = 1011011 (2)
		  -- HEX2 = 0000111 (7) 
		  -- Rest 0111111 (0) 
		  
		  wait for 2 * TbPeriod;
		  
		  SW <= "011111111"; -- hex mode, expect 7F
		  -- Expecting....
		  -- HEX0 = 0000111 (7) 
		  -- HEX1 = 1110001 (F)
		  -- Rest 0111111 (0) 
		  
		  wait for 2 * TbPeriod;
		  
		  button <= 1; -- Store 7F
		  
		  wait for 2 * TbPeriod;
		  
		  button <=0;
		  
		  wait for 2 * TbPeriod;
		  
		  SW <= "0110101100"; -- hex mode, expect AC
		  -- Expecting....
		  -- HEX0 = 1110111 (A) 
		  -- HEX1 = 0111001 (C)
		  -- Rest 0111111 (0) 
		  
		  wait for 2 * TbPeriod;
		  
		  SW <= "1010101100"; -- display stored value 
		  -- Expecting....
		  -- HEX0 = 0000111 (7) 
		  -- HEX1 = 1110001 (F)
		  -- Rest 0111111 (0) 
		  
		  wait for 2 * TbPeriod;
		  
		  SW <= "1110101100"; -- display 5A5A
		  -- Expecting....
		  -- HEX0 = 1101101 (5) 
		  -- HEX1 = 1110111 (A)
		  -- HEX2 = 1101101 (5) 
		  -- HEX4 = 1110111 (A)
		  
		  wait for 2 * TbPeriod;
		  
		  reset_n <= '0'; -- reset 
		  
		  