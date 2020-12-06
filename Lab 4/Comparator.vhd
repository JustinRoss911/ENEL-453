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
		 bool       :out std_logic_vector(1 downto 0)
      );
end Comparator;

architecture behaviour of Comparator is
begin
	process(clk,reset_n)
		begin
       if(reset_n = '0') then -- reset low
           bool <= "00";
       elsif (rising_edge(clk)) then  
			 if ((unsigned(dist_in) < 2000) and (unsigned(dist_in) > 450)) then -- distance < 20cm, bool = 1 (flashing)
				bool <= "01";
			 elsif (unsigned(dist_in) < 450) then -- min 4.50
				bool <= "10";
			 else 
				bool <= "11";  -- stable 
			 end if;
		end if;
	end process; 
end behaviour; 