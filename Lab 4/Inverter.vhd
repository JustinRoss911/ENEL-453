--Inverter 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity Inverter is
port ( B : in std_logic;
		 Y : out std_logic
      );
end Inverter;

architecture behaviour of Inverter is
begin
	Y <= not(B); 
end behaviour; 