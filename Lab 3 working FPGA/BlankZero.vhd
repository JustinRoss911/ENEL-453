
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
port ( Q       : in  std_logic_vector(15 downto 0); -- The items about to be displayed to the seven segment display, range would need to be modified to (23 downto 0) to accomedate all the buttons
       Blank 	: out std_logic_vector(5 downto 0)  -- output bits 
      );
end BlankZero;
----------------------------------------------------------------
-- 3. Architecture 
----------------------------------------------------------------
architecture behaviour of BlankZero is

begin
	process (Q) -- maybe (Q, Blank)
		begin
		
			 -- default for current Q range
			
			if (Q(15 downto 12) /= "0000") then -- /= is not equal to 
				Blank <= "110000";
			elsif (Q(11 downto 8) /= "0000") then
				Blank <= "111000";
			elsif (Q(7 downto 4) /= "0000") then
				Blank <= "111100";
			elsif (Q(3 downto 0) /= "0000") then
				Blank <= "111110";
			else 
				Blank <= "111111";
			end if;
			
	end process;
	
end behaviour;
	
--
--Signal tmp: std_logic_vector(15 downto 0);
--
--begin 
--	process 
--		begin 
--	
--	   with s select tmp <= 
--		in1 when "00",
--		in2 when "01",
--		in3 when "10",
--		in4 when others;
--
--		 
--		Blank <= "110000"; -- set to default 			 
--					
--		for i in 4 to 1 loop  
--				  if (or_reduce(mux_out((4*i)-1 downto (4*i)-4)) = '1') then  -- or_reduce OR's the bits 
--							exit; 		
--				  else 
--							Blank(i) <= '1';
--				  end if;
--		end loop;
--
--	end process;
--	
--end behaviour; 
----------------------------------------------------------------