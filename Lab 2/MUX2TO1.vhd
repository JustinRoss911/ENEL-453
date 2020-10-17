-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity MUX2TO1 is
port ( in1     : in  std_logic_vector(15 downto 0); -- in1 = binary 
       in2     : in  std_logic_vector(15 downto 0); -- in2 = decimal 
       s       : in  std_logic; 							 -- Switch that toggles between binary and hex
       mux_out : out std_logic_vector(15 downto 0)  -- put bits 
      );
end MUX2TO1;
----------------------------------------------------------------
-- 3. Architecture 
----------------------------------------------------------------
architecture BEHAVIOR of MUX2TO1 is
	begin
		with s select
			mux_out <= in1 when '0', -- when s is '0' then mux_out becomes in1
			           in2 when others;

end BEHAVIOR; 
----------------------------------------------------------------
