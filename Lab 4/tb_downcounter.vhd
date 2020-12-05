library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_downcounter is
end tb_downcounter;

architecture tb of tb_downcounter is
	Component downcounter is   
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enab  : in  STD_LOGIC; -- active-high enable (I don't know what the purpose of enable is in this module) 
              zero    : out STD_LOGIC;  -- creates a positive pulse every time current_count hits zero
              period :in std_logic_vector(15 downto 0)                         -- useful to enable another device, like to slow down a counter
              --value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         );
	END Component;
	
	Signal reset_n: std_logic;
	Signal enab, zero: std_logic; 
	Signal period: std_logic_vector(15 downto 0);
	Signal clk : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
begin

    UUT : downcounter
    port map (clk     => clk,
              reset_n => reset_n,
				  enab     => enab,
				  zero => zero,
				  period => period);
				  		  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; 
		  period <= "0000000000000101";
		  enab <= '1';
		  
		  wait for 1000*TbPeriod;
		  
		  reset_n <= '1';
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  period <= "0000000000010100";
		  
		  --wait for 25_000_000*TbPeriod;
		  wait for 1000*TbPeriod;
		  
		  period <= "0000000001010100";
		  
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