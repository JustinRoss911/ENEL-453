-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity DPmux is
port ( dp1 	  : in  std_logic_vector(5 downto 0);
		 dp2	  : in  std_logic_vector(5 downto 0);
		 dp3	  : in  std_logic_vector(5 downto 0);
		 dp4	  : in  std_logic_vector(5 downto 0);
		 s      : in  std_logic_vector(1 downto 0); 
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
			
			
-- Think we should include Blanking feature in here so it can be saved when button pressed 					
--	with s select tmp <= 
--			in1 when "00",
--			in2 when "01",
--			in3 when "10",
--			in4 when others;		
--	
--	  Blank <= "11000" -- default; 
--	  
--	  Loop1: for i in 3 to 0 loop 
--            if (or_reduce(tmp) != 0) -- only blank until first non-zero 
--					break; 		
--				else 
--				   Blank(i) = '1';
--	  end loop LoopA1;
	
			
end behaviour; 
----------------------------------------------------------------