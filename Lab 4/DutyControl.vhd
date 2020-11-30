-- DutyControl

-- This module controls the one time of PWD thorugh the duty cycle 
-- For the LED's we want to increase the duty cycle with decreased distance (increase one time == brighter) 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
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
begin 
	process(clk,reset_n)
		begin
       if(reset_n = '0') then 
			  set_duty <= (others => '0');
       elsif (rising_edge(clk)) then  
			  set_duty <= "100000000";
		 end if; 
	 end process; 	
end behaviour;
	