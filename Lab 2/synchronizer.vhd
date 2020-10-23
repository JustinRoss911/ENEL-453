-- synchronizer module

-- library decleration
library ieee;
use ieee.std_logic_1164.all;

-- entitiy decleration
entity synchronizer is
	port	(A:	in		std_logic_vector(9 downto 0);
			 CLK:	in 	std_logic;
			 G:	out	std_logic_vector(9 downto 0)
			 );
end synchronizer;

-- architecture decleration

architecture behaviour of synchronizer is
signal E: std_logic_vector(9 downto 0);
begin
	process(CLK)
		begin
			if rising_edge(CLK) then
				E <= A;
				G <= E;
			end if;
	end process;
end behaviour;