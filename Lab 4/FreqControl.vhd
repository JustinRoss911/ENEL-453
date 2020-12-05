-- FreqControl

-- This module controls the frequency of PWD thorugh the counter_max 
-- For the Sev_seg and buzzer we want to decrease the set_count with decreased distance (increase frequency) 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
----------------------------------------------------------------
-- 2. Entity Declaration 
----------------------------------------------------------------
entity FreqControl is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 input   	:in std_logic_vector(12 downto 0); 
		 set_duty_cycle :out std_logic_vector(8 downto 0); 
		 set_count	:out std_logic_vector(8 downto 0)
      );
end FreqControl;

architecture behaviour of FreqControl is
Signal temp: std_logic_vector (8 downto 0);

begin 
	process(clk,reset_n)
		begin
       if(reset_n = '0') then -- reset low
           set_count <= (others => '0');
       elsif (rising_edge(clk)) then 
			  --set_count <= "111111111";
			  --temp <= "111111111";
			  
			  -- distance FAR: Max counter is 510 = duty cycle 255
			  -- distance CLOSE: Min counter is 4 = duty cycle 2
			  -- (0, 510), (4095, 4) 
			  
			  set_count <= std_logic_vector(to_unsigned(d2count_LUT(to_integer(unsigned(input))),set_count'length));-- set maximum value above counter limit (no flashing) 
			  temp <= std_logic_vector(to_unsigned(d2count_LUT(to_integer(unsigned(input))),temp'length));
			  set_duty_cycle <= std_logic_vector(unsigned(temp)/2); -- set duty cycle to half maximum counter so Ton=Toff
		 end if; 
	 end process; 	
end behaviour;
	
	
	