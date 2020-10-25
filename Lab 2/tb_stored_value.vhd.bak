--testbench code for stored_value 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_stored_value is
end tb_stored_value;

architecture tb of tb_stored_value is
	Component stored_value is 
		Port ( 
				D     				: in  std_logic_vector(7 downto 0); -- output of synchronizer 
				EN, reset_n, clk  : in  std_logic;							-- EN is ouput of debounce 				  
				Q     				: out std_logic_vector(7 downto 0)  -- input to mux 
				);
	END Component;
	
	Signal D, Q : std_logic_vector(7 downto 0);
	Signal EN, reset_n : std_logic;
	Signal clk : std_logic := '0';
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';

begin

    UUT : stored_value
    port map (D       => D,
              EN      => EN,
              reset_n => reset_n,
              clk     => clk,
              Q       => Q);

    -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
        -- Initialization
        D <= "00000000";
		  reset_n <= '1';
        EN <= '0';

        wait for 2 * TbPeriod;
		  
		  -- Start tests 
		  
		  D <= "10101010";
		  wait for 2 * TbPeriod;
		  
		  
		  D <= "01010101";
		  wait for 2 * TbPeriod;
		  
		  En <= '1';
		  wait for 2 * TbPeriod;
		  
		  D <= "11110000";
		  wait for 2 * TbPeriod;
		  
		  D <= "00001111";
		  wait for 2 * TbPeriod;
		  
		  reset_n <= '0';
		  wait for 2 * TbPeriod;
		  
		  D <= "11001100";
		  wait for 2 * TbPeriod;
		  
		  D <= "00110011";
		  wait for 2 * TbPeriod;
		  
		  EN <= '0';
		  wait for 2 * TbPeriod;
		  
		  D <= "11111111";
		  wait for 2 * TbPeriod;
		  
		  D <= "10101010";
		  wait for 2 * TbPeriod;
 
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;