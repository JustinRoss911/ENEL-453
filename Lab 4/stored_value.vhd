
-- stored_value.vhd

-- this if the behavioural code for the register thats stores the current switch input value when the pushbutton is pressed 

-- 1. Library Declaration 
---------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity stored_value is
port ( D     				: in  std_logic_vector(21 downto 0); -- switch inputs  
       EN, reset_n, clk   : in  std_logic;											  
		 Q     				: out std_logic_vector(21 downto 0)  -- output to mux 
      );
end stored_value;
----------------------------------------------------------------
-- 3. Architecture 
----------------------------------------------------------------
architecture behaviour of stored_value is
	begin
		process(clk, reset_n) 
			begin 
				if reset_n = '0' then 		-- If reset=0, Q gets zero (synchronous reset)  
					Q <= "0000000000000000000000";
				elsif rising_edge(clk) then
					if (EN = '1') then 			-- If EN=1, Q gets D 
						Q <= D; 
					end if;
				end if; 
			end process;
	end behaviour; 		
----------------------------------------------------------------