-- DutyControl

-- This module controls the one time of PWD thorugh the duty cycle 
-- For the LED's we want to increase the duty cycle with decreased distance (increase one time == brighter) 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;
--use work.LUT2_pkg.all; -- note that this package stores the look up table, to make this code cleaner

----------------------------
------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity DutyControl is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 input_dist :in std_logic_vector(12 downto 0); 
		 set_duty   :out std_logic_vector(8 downto 0)
      );
end DutyControl;

architecture behaviour of DutyControl is
Signal temp : integer := 1;
Signal hold :std_logic_vector(12 downto 0);
--Constant factor : integer := -113/2707;
--Constant temp: unsigned; 

-- input_dist will be any value up to 5414
-- maximum set_duty will be 511
-- make a scaling factor of input_distance/maximum_distance then multiply it by maximum duty
-- subtract by maximum duty to get brighter at closer distances and dimmer at further distances 

begin 
	process(clk,reset_n)
		begin
       if(reset_n = '0') then 
			  set_duty <= "111111111";
       elsif (rising_edge(clk)) then  
			  --set_duty <= ((std_logic_vector((unsigned(input_dist)-5414))) sll 1)/temp;
			  
			  
			  set_duty <= std_logic_vector(388 - unsigned(input_dist(12 downto 4))); --388 is the maximum value if input_dist is 
			  
			  -- Apprxomate an exponential equation with two linear equations
--			  if(unsigned(input_dist)>1000) then
--			     set_duty <= std_logic_vector((-0.0113*(to_integer(input_dist))) + 61);   -- y = -0.0113x+61
--			  else 
--			    set_duty <= std_logic_vector((-0.846*(to_integer(input_dist))) + 895);	-- y = -0.846x+895 (steeper) 
--			  end if;
			  
			  --set_duty <= std_logic_vector(to_unsigned(d2max_LUT(to_integer(unsigned(input_dist))),set_duty'length));	  
--			  if (unsigned(input_dist) < 511) then
--				  set_duty <= "111111111";
--			  else 
--					temp <= to_integer(unsigned(input_dist))/511;
--					hold <= input_dist sll temp;
--					set_duty <= hold(8 downto 0);
--				end if;

		 end if; 
	 end process; 	
end behaviour;


-- Use half a parabolic equation y = 0.0000175(x-5141)^2 
-- This will give maximum duty cycle at distance = 0 and minimum (off) at x=5414


	