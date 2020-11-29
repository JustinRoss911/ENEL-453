-- FreqControl

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity FreqControl is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 input   		:in std_logic_vector(12 downto 0); -- in1 = hex switch display
		 set_count		:out std_logic_vector(9 downto 0)
      );
end FreqControl;

architecture behaviour of FreqControl is
begin 
	process(clk,reset_n)
		begin
       if(reset_n = '0') then -- reset low
           set_count <= (others => '0');
       elsif (rising_edge(clk)) then 
			if ( unsigned(input) > 4000) then
				set_count <= "1000000000";  -- set maximum value above counter limit (no flashing) 
			else
			-- update later. 
			-- output a small set_count for a small distance 
				set_count <= "0100000000"; 
			end if;
		 end if; 
	 end process; 	
end behaviour;
	
	
	