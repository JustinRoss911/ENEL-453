library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity SevSegmodule is
    Port ( clk                           : in std_logic;
           reset_n                       : in std_logic;
			  dist2	 							  : in std_logic_vector(12 downto 0); 
           pwm                           : out std_logic
          );
           
end SevSegmodule;

architecture Behavioral of SevSegmodule is

Signal input   	:std_logic_vector(12 downto 0); 
Signal set_count, set_duty_cycle, count_max, duty_cycle :std_logic_vector(8 downto 0);
Signal enab, zero, enable, pwm_out: std_logic;


Component FreqControl is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 input   	:in std_logic_vector(12 downto 0); 
		 set_duty_cycle :out std_logic_vector(8 downto 0); 
		 set_count	:out std_logic_vector(8 downto 0)
      );
end Component;

Component downcounter is
 Generic ( period  : natural := 1000); -- number to count       
 PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enab  : in  STD_LOGIC; -- active-high enable (I don't know what the purpose of enable is in this module) 
              zero    : out STD_LOGIC  -- creates a positive pulse every time current_count hits zero
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

enab <= '1'; -- Always leave downcounter on. A mux will choose when output is from pwm or 0 
	
downcounter_ins1: downcounter 	
	Generic Map (period => 1000) -- number to count       
   PORT Map  (clk     => clk, -- clock to be divided
              reset_n => reset_n, -- active-high reset
              enab  => enab, -- active-high enable
              zero    => zero  -- creates a positive pulse every time current_count hits zero
            );
				
count_max <= set_count; 
enable <= zero;
duty_cycle <= set_duty_cycle; 
		
PWM_DAC_ins1: PWM_DAC
  Generic Map (width => 9)
  Port Map    (reset_n  => reset_n,
               clk      => clk, 
				   count_max  => count_max,
               duty_cycle  => duty_cycle, 
				   enable 		=> enable, 
               pwm_out  => pwm_out  
           );
			  
input <= dist2; 
			  
FreqControl_ins1: FreqControl
Port Map (reset_n  => reset_n,
          clk  => clk, 
			 input  => input, 
		    set_count => set_count,	
			 set_duty_cycle => set_duty_cycle
         );
			
pwm <= pwm_out;

end Behavioral; 
