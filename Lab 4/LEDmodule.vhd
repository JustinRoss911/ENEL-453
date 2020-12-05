---------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity LEDmodule is
    Port ( clk                           : in std_logic;
           reset_n                       : in std_logic;
			  dist	 							  : in std_logic_vector(12 downto 0); 
           LEDout                        : out std_logic
          );
           
end LEDmodule;

architecture Behavioral of LEDmodule is

Signal enable, pwm_out: std_logic;
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


begin 

count_max <= "111111111";
duty_cycle <= set_duty;
enable <= '1';

PWM_DAC_ins2: PWM_DAC
Generic Map (width => 9)
Port Map    (reset_n  => reset_n,
             clk      => clk, 
				 count_max  => count_max,
             duty_cycle  => duty_cycle, 
				 enable 		=> enable, 
             pwm_out  => pwm_out 
           );

				
input_dist <= dist; 

DutyControl_ins: DutyControl 
port map( 
		 reset_n    => reset_n,
       clk        => clk,
		 input_dist => input_dist,
		 set_duty   => set_duty
      );
		
LEDout <= pwm_out; -- set LEDs to pwm_out
			  
end Behavioral;
			  
