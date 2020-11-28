-- synchronizer module

-- library decleration
library ieee;
use ieee.std_logic_1164.all;

-- entitiy decleration
entity synchronizer is
	port	(A:	in		std_logic_vector(9 downto 0);
			 clk, reset_n:	in 	std_logic;
			 G:	out	std_logic_vector(9 downto 0)
			 );
end synchronizer;

-- architecture decleration

architecture behaviour of synchronizer is
signal E: std_logic_vector(9 downto 0);
begin
    process(clk, reset_n)
        begin
            if reset_n = '0' then
                E <= "0000000000";
                G <= "0000000000";
            elsif rising_edge(clk) then
                E <= A;
                G <= E;
            end if;
    end process;
end behaviour;