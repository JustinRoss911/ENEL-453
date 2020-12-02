---------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity LEDmodule is
    Port ( clk                           : in std_logic;
           reset_n                       : in std_logic;
			  threshold							  : in std_logic;
			  dist	 							  : in std_logic_vector(12 downto 0); 
           LEDR                          : out std_logic_vector (9 downto 0)
          );
           
end LEDmodule;

architecture Behavioral of LEDmodule is

Signal enable, pwm_out, enab, zero: std_logic;
Signal input_dist: std_logic_vector(12 downto 0);
Signal set_duty, count_max, duty_cycle: std_logic_vector(8 downto 0);


Component DutyControl is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 input_dist :in std_logic_vector(12 downto 0); 
		 set_duty   :out std_logic_vector(8 downto 0)
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

Component downcounter is
    Generic ( period  : natural := 1000); -- number to count       
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enab  : in  STD_LOGIC; -- active-high enable
              zero    : out STD_LOGIC  -- creates a positive pulse every time current_count hits zero
                                       -- useful to enable another device, like to slow down a counter
              -- value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         );
end component;

begin 

count_max <= "111111111";
duty_cycle <= set_duty;
enable <= zero;
--enable <= '1';

PWM_DAC_ins2: PWM_DAC
  Generic Map (width => 9)
  Port Map    (reset_n  => reset_n,
               clk      => clk, 
				   count_max  => count_max,
               duty_cycle  => duty_cycle, 
				   enable 		=> enable, 
               pwm_out  => pwm_out 
           );

enab <= threshold; 
			  
downcounter_ins2: downcounter 	
	Generic Map (period => 1000) -- number to count       
   PORT Map  (clk     => clk, -- clock to be divided
              reset_n => reset_n, -- active-high reset
              enab  => enab, -- active-high enable
              zero    => zero  -- creates a positive pulse every time current_count hits zero
            );
				
input_dist <= dist; 

DutyControl_ins: DutyControl 
port map( reset_n    => reset_n,
       clk        => clk,
		 input_dist => input_dist,
		 set_duty   => set_duty
      );
		
LEDR(9 downto 0) <= (others => not(pwm_out));
			  
end Behavioral;
			  
