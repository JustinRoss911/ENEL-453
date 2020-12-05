library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_SevSegmodule is
end tb_SevSegmodule;

architecture tb of tb_SevSegmodule is
	Component SevSegmodule is 
    Port ( clk                           : in std_logic;
           reset_n                       : in std_logic;
			  dist2	 							  : in std_logic_vector(12 downto 0); 
           pwm                          : out std_logic
          );
	END Component;
	
	Signal reset_n: std_logic;
	Signal pwm: std_logic; 
	Signal dist2: std_logic_vector(12 downto 0);
	Signal clk : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : SevSegmodule
    port map (clk     => clk,
              reset_n => reset_n,
				  dist2     => dist2,
				  pwm => pwm);
				  		  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; -- reset (put everything in a known state) 
		  --dist2 <= "0001111101000";
		  dist2 <= "0000111110100";

        wait for 1000*TbPeriod;
		  
		  reset_n <= '1';
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0101110110111";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0100000010001";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0000011010001";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0000000010001";
		
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0001000010010";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0000100101100";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  --dist2 <= "0000110110110";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
        TbSimEnded <= '1';
        
		  wait;
    
	 end process;

end tb;
		  
		  