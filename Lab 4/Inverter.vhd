--Inverter 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity Inverter is
port ( reset_n   : in  STD_LOGIC;
       clk       : in  STD_LOGIC;
		 B : in std_logic;
		 Y : out std_logic
      );
end Inverter;

architecture behaviour of Inverter is
begin
	process(clk,reset_n)
		begin
       if(reset_n = '0') then 
			  Y <= '0';
		 elsif (rising_edge(clk)) then  
			  Y <= not(B); 
		 end if;
	end process;
end behaviour; 