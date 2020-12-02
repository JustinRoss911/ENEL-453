
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_LEDmodule is
end tb_LEDmodule;

architecture tb of tb_LEDmodule is
	Component LEDmodule is 
    Port ( clk                           : in std_logic;
           reset_n                       : in std_logic;
			  threshold							  : in std_logic;
			  dist	 							  : in std_logic_vector(12 downto 0); 
           LEDR                          : out std_logic_vector (9 downto 0)
          );
	END Component;
	
	Signal reset_n, threshold: std_logic;
	Signal LEDR: std_logic_vector(9 downto 0); 
	Signal dist: std_logic_vector(12 downto 0);
	Signal clk : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : LEDmodule
    port map (clk     => clk,
              reset_n => reset_n,
              threshold  => threshold,
				  dist     => dist,
				  LEDR => LEDR);
				  		  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; -- reset (put everything in a known state) 
		  threshold <= '0';	-- do not store current value 
		  dist <= "0111110100000"; -- binary mode, input 0 

        wait for 1_600_000*TbPeriod;
		  
		  reset_n <= '1';
		  
		  wait for 1_600_000*TbPeriod;
		  
		  dist <= "0101110110111";
		  threshold <= '1';
		  
		  --dist <= "0111110100000";
		  
		  wait for 1_600_000*TbPeriod;
		  
		  dist <= "0100000010001";
		  
		  wait for 1_600_000*TbPeriod;
		  
		  dist <= "0000011010001";
		  --threshold <= '1';
		  
		  wait for 1_600_000*TbPeriod;
		  
		  dist <= "0000000010001";
		
		  wait for 1_600_000*TbPeriod;
		  
		  --dist <= "0001000010010";
		  
		  --wait for 1_600_000*TbPeriod;
		  
		  --dist <= "0000100101100";
		  
		  --wait for 1_600_000*TbPeriod;
		  
		  --dist <= "0000110110110";
		  
		  --wait for 1_600_000*TbPeriod;
		  
        TbSimEnded <= '1';
        
		  wait;
    
	 end process;

end tb;
		  
		  
		  