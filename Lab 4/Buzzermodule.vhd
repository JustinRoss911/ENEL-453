library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
--use work.LUT_flashing_pkg.all;
--use work.LUT_SevSeg_pkg.all;

entity BuzzerModule is
    Port ( clk                           : in std_logic;
           reset_n                       : in std_logic;
			  dist3	 							  : in std_logic_vector(12 downto 0); 
           buzz                           : out std_logic
          );
           
end BuzzerModule;

architecture Behavioral of BuzzerModule is

Signal period :std_logic_vector(15 downto 0);
Signal count_max, duty_cycle :std_logic_vector(8 downto 0);
Signal enab, zero, enable, pwm_out: std_logic;

Component downcounter is      
 PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
           reset_n : in  STD_LOGIC; -- active-high reset
           enab  : in  STD_LOGIC; -- active-high enable (I don't know what the purpose of enable is in this module) 
           zero    : out STD_LOGIC;  
			  period :in std_logic_vector(15 downto 0)    -- creates a positive pulse every time current_count hits zero
           );
end Component;

Component PWM_DAC is
   Generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
             clk        : in  STD_LOGIC;
				 count_max  : in  STD_LOGIC_VECTOR (width-1 downto 0); -- maximum count value (1 bit greater than counter width) 
             duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
				 enable 		: in  STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
end component;

begin

enab <= '1'; -- Always leave downcounter on. A mux will choose when output is from buzz or 0 
--period <= std_logic_vector(to_unsigned(d2buzz_LUT(to_integer(unsigned(dist2))),period'length)); -- adjust for buzzer
period <= "1111111111111111";

downcounter_ins1: downcounter 	     
   PORT Map  (clk     => clk, -- clock to be divided
              reset_n => reset_n, -- active-high reset
              enab  => enab, -- active-high enable
              zero    => zero,
				  period => period  -- creates a positive pulse every time current_count hits zero
            );
				
count_max <= "111111111"; 
--count_max <= "000001000"; 
enable <= zero;
duty_cycle <= "011111111"; 
--duty_cycle <= "000000100"; 
		
PWM_DAC_ins1: PWM_DAC
  Generic Map (width => 9)
  Port Map    (reset_n  => reset_n,
               clk      => clk, 
				   count_max  => count_max,
               duty_cycle  => duty_cycle, 
				   enable 		=> enable, 
               pwm_out  => pwm_out  
           );
			  
			
buzz <= pwm_out;

end Behavioral; 
