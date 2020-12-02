library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;
----------------------------------------------------------------
entity ANDgate is
port ( C    : in  STD_LOGIC_vector(21 downto 0);
       factor : in  STD_LOGIC;
		 K :out std_logic_vector(21 downto 0)
      );
end ANDgate;

architecture behaviour of ANDgate is
Signal temp: std_logic_vector(21 downto 0); 

begin
	temp(21 downto 0) <= (others => factor);
	K <= C AND temp; -- make this a seperate module
end behaviour;
