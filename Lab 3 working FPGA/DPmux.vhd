-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity DPmux is
port ( dp1 	  : in  std_logic_vector(5 downto 0); -- constant defined in top level
		 dp2	  : in  std_logic_vector(5 downto 0);
		 dp3	  : in  std_logic_vector(5 downto 0);
		 dp4	  : in  std_logic_vector(5 downto 0);
		 s      : in  std_logic_vector(1 downto 0); -- mode
       dp_out : out std_logic_vector(5 downto 0)  
      );
end DPmux;
----------------------------------------------------------------
-- 3. Architecture 
----------------------------------------------------------------
architecture behaviour of DPmux is
	begin
			with s select dp_out <= 
			dp1 when "00",
			dp2 when "01",
			dp3 when "10",
			dp4 when others;
			
end behaviour; 
----------------------------------------------------------------