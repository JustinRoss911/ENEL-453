library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM_DAC is
   Generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
             clk        : in  STD_LOGIC;
				 count_max  : in  STD_LOGIC_VECTOR (width-1 downto 0); -- maximum count value (1 bit greater than counter width) 
             duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
				 enable 		: in  STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
end PWM_DAC;

architecture Behavioral of PWM_DAC is
   signal counter : unsigned (width-1 downto 0); -- 9 bit counter  
       
begin
   count : process(clk,reset_n)
   begin
       if( reset_n = '0') then -- reset low
           counter <= (others => '0');
       elsif (rising_edge(clk)) then 
			  if (enable = '1') then 
				 if (counter < unsigned(count_max)) then -- if counter is less than max continue to increment 
					counter <= counter + 1; 
				 else -- if counter is at max value set counter back to zero 
					counter <= (others => '0');
			    end if;
			  else 
					counter <= (others => '0');  -- if enable = 0 set counter to zero to force pwm_out to 1 (no flashing) 
					-- This will start the period over again 
			  end if;
       end if;
   end process;
 
   compare : process(counter, duty_cycle) -- run when counter has changed (from rising clock edge) 
   begin    
       if (counter < unsigned(duty_cycle)) then -- if counter is less than Ton/Tperiod 
           pwm_out <= '1'; -- logic high 
       else 
           pwm_out <= '0'; -- if counter is greater than Ton/Tperiod set logic low 
       end if;
   end process;
  
end Behavioral;

