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
			mux_out <= in1 when "00", -- when s is 00, mux_out is in1 (binary)
			           in2 when "01", -- when s is 01, mux_out is in2 (decimal)
						  in3 when "10", -- when s is 10, mux_out is the stored value 
						  in4 when others; -- when s is 11, mux_out is 5A5A

end behaviour; 
----------------------------------------------------------------