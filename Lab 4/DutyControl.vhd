-- DutyControl

-- This module controls the one time of PWD thorugh the duty cycle 
-- For the LED's we want to increase the duty cycle with decreased distance (increase one time == brighter) 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;
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
--Constant temp : integer := ((5414)**2)/512;
--Constant factor : integer := -256/2707;
--Constant temp: unsigned; 

-- input_dist will be any value up to 5414
-- maximum set_duty will be 511
-- make a scaling factor of input_distance/maximum_distance then multiply it by maximum duty
-- subtract by maximum duty to get brighter at closer distances and dimmer at further distances 

begin 
	process(clk,reset_n)
		begin
       if(reset_n = '0') then 
			  set_duty <= (others => '0');
       elsif (rising_edge(clk)) then  
			  --set_duty <= ((std_logic_vector((unsigned(input_dist)-5414))) sll 1)/temp;
			  --temp <= (511-(511*(unsigned(input_dist)/5414)));  
			  --set_duty <= std_logic_vector(temp); --(8 downto 0);
			  --set_duty <= std_logic_vector(unsigned(input_dist)*temp);
			  --set_duty <= std_logic_vector(unsigned(input_dist)/5414);
			  set_duty <= std_logic_vector(388 - unsigned(input_dist(12 downto 4))); --388 is the maximum value if input_dist is 
		 end if; 
	 end process; 	
end behaviour;


-- Use half a parabolic equation y = 0.0000175(x-5141)^2 
-- This will give maximum duty cycle at distance = 0 and minimum (off) at x=5414


	