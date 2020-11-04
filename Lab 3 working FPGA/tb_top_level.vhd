--testbench code for top level 

-- not working right now ?

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is
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
	Signal HEX0,HEX1,HEX2,HEX3,HEX4,HEX5: std_logic_vector (7 downto 0);
	Signal clk : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : top_level
    port map (clk     => clk,
              reset_n => reset_n,
              button  => button,
				  SW      => SW,
				  LEDR => LEDR,
				  HEX0 => HEX0,
				  HEX1 => HEX1,
				  HEX2 => HEX2,
				  HEX3 => HEX3,
				  HEX4 => HEX4,
				  HEX5 => HEX5);
				  
				  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; -- reset (put everything in a known state) 
		  button <= '1';	-- do not store current value 
		  SW <= "0000000000"; -- binary mode, input 0 

        --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  reset_n <= '1';
		  
		  --wait for 1_600_000*TbPeriod;
			wait for 500*TbPeriod;
		  
		  SW <= "0011111111";  
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  SW <= "0111111111"; -- hex mode, expect FF
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  button <= '0'; -- Hold current input
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  SW <= "0100110011"; 
		
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  button <= '1';
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  SW <= "0110101100"; -- hex mode, expect AC
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  SW <= "1010101100"; -- display stored value while inputs show AC
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  SW <= "1110101100"; -- display 5A5A while inputs show AC
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
		  reset_n <= '0'; -- reset 
		  
		  --wait for 1_600_000*TbPeriod;
		  wait for 500*TbPeriod;
		  
        TbSimEnded <= '1';
        
		  wait;
    
	 end process;

end tb;
		  
		  
		  