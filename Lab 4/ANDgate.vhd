library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;
----------------------------------------------------------------
entity ANDgate is
port ( C    : in  STD_LOGIC_vector(21 downto 0);
       factor : in  STD_LOGIC;
		 Enable1, reset_n, clk : in STD_logic;
		 K :out std_logic_vector(21 downto 0)
      );
end ANDgate;

architecture behaviour of ANDgate is
Signal temp: std_logic_vector(21 downto 0); 

begin
		process(clk, reset_n) 
			begin 
				if reset_n = '0' then 		
					K <= "0000000000000000000000";
				elsif rising_edge(clk) then
					if (Enable1 = '0') then 			-- If button is pressed make sure output is stable
						temp(21 downto 0) <= (others => '1');
						K <= C AND temp;
					else 
						temp(21 downto 0) <= (others => factor); --If button is not pressed make sure output is flashing
						K <= C AND temp; 
					end if;
				end if; 
			end process;
end behaviour;
