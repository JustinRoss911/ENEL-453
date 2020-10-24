-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity MUX4TO1 is
port ( in1     : in  std_logic_vector(15 downto 0); -- in1 = binary (hex)
       in2     : in  std_logic_vector(15 downto 0); -- in2 = decimal 
		 in3     : in  std_logic_vector(15 downto 0); -- in3 = stored value 
		 in4     : in  std_logic_vector(15 downto 0); -- in4 = 5A5A
       s       : in  std_logic_vector(1  downto 0); -- Switches that toggles between mode
       mux_out : out std_logic_vector(15 downto 0)  -- output bits 
      );
end MUX4TO1;
----------------------------------------------------------------
-- 3. Architecture 
----------------------------------------------------------------
architecture behaviour of MUX4TO1 is
	begin
		with s select
			mux_out <= in1 when "00",
			           in2 when "01",
						  in3 when "10",
						  in4 when others;

end behaviour; 
----------------------------------------------------------------