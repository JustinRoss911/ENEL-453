
-- I satrted working on a moduel to blank leading zeros but I think this should be incorporated into DPmux 


-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_MISC.or_reduce;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity BlankZero is
port ( in1     : in  std_logic_vector(15 downto 0); -- in1 = hex switch display
       in2     : in  std_logic_vector(15 downto 0); -- in2 = decimal distance output
		 in3     : in  std_logic_vector(15 downto 0); -- in3 = decimal votlage output
		 in4     : in  std_logic_vector(15 downto 0); -- in4 = hex moving average 
       s       : in  std_logic_vector(1 downto 0); -- Switches that toggles between mode
       Blank 	: out std_logic_vector(5 downto 0)  -- output bits 
      );
end BlankZero;
----------------------------------------------------------------
-- 3. Architecture 
----------------------------------------------------------------
architecture behaviour of BlankZero is

Signal tmp std_logic_vector(15 downto 0);
	
	if s 
		
	with s select tmp <= 
			in1 when "00",
			in2 when "01",
			in3 when "10",
			in4 when others;		
	
	  Blank <= "11000" -- default; 
	  
	  Loop1: for i in 3 to 0 loop 
            if (or_reduce(tmp) != 0) -- only blank until first non-zero 
					break; 		
				else 
				   Blank(i) = '1';
	  end loop LoopA1;
	

end behaviour; 
----------------------------------------------------------------