library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity Mux2 is
port ( in_1      	:in  std_logic_vector(21 downto 0); 
		 in_2			:in  std_logic_vector(21 downto 0); 
		 control    :in  std_logic;
		 out_sig    :out  std_logic_vector(21 downto 0)
      );
end Mux2;

architecture behaviour of Mux2 is	
	begin
		with control select out_sig <= 
			in_1 when '0',
			in_2 when others;
end behaviour; 