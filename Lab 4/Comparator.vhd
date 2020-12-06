--Comparator 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity Comparator is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 dist_in    	:in std_logic_vector(12 downto 0); 
		 bool       :out std_logic
      );
end Comparator;

architecture behaviour of Comparator is
begin
	process(clk,reset_n)
		begin
       if(reset_n = '0') then -- reset low
           bool <= '0';
       elsif (rising_edge(clk)) then  
			 if (unsigned(dist_in) < 3000) then -- distance < 20cm, bool = 1
				bool <= '1';
			else 
				bool <= '0';
			 end if;
		end if;
	end process; 
end behaviour; 