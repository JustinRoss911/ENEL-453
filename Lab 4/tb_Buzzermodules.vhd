library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Buzzermodules is
end tb_Buzzermodules;

architecture tb of tb_Buzzermodules is
	Component Buzzermodule is 
    Port ( clk_in                        : in std_logic;
           reset_n                       : in std_logic;
			  dist3	 							  : in std_logic_vector(12 downto 0); 
           buzz                         : out std_logic
          );
	END Component;
	
	Signal reset_n: std_logic;
	Signal buzz: std_logic; 
	Signal dist3: std_logic_vector(12 downto 0);
	Signal clk_in : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : Buzzermodule
    port map (clk_in     => clk_in,
              reset_n => reset_n,
				  dist3     => dist3,
				  buzz => buzz);
				  		  
	 -- Clock generation
    clk_in <= not clk_in after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; -- reset (put everything in a known state) 
		  --dist3 <= "0001111101000";
		  dist3 <= "0000111110100";

        wait for 5*TbPeriod;
		  
		  reset_n <= '1';
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0101110110111";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0100000010001";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0000011010001";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0110101111100";
		
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0001000010010";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0111111010010";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
		  dist3 <= "0000110110110";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 18000*TbPeriod;
		  
        TbSimEnded <= '1';
        
		  wait;
    
	 end process;

end tb;
		  
		  