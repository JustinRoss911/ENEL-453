library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity bitmux is
port ( in_1      	:in  std_logic; 
		 in_2			:in  std_logic; 
		 control    :in  std_logic;
		 out_sig    :out  std_logic
      );
end bitmux;

architecture behaviour of bitmux is	
	begin
		with control select out_sig <= 
			in_1 when '0',
			in_2 when others;
end behaviour; 