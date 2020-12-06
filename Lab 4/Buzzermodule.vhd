library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
use work.LUT_buzzing_pkg.all;
--use work.LUT_SevSeg_pkg.all;

entity BuzzerModule is
    Port ( clk_in                         : in std_logic;
           reset_n                       : in std_logic;
			  dist3	 							  : in std_logic_vector(12 downto 0); 
           buzz                           : out std_logic
		 );
		  
end BuzzerModule;

architecture Behavioral of BuzzerModule is

Signal zero, enable, pwm_out : std_logic;
Signal clk : std_logic;
Signal distance : std_logic_vector (12 downto 0);
Signal count_max, duty_cycle : std_logic_vector (8 downto 0);

Component buzzer_downcounter is
      
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
				  distance : in  STD_LOGIC_VECTOR (12 downto 0);
              reset_n : in  STD_LOGIC; -- active-high reset
              zero    : out STD_LOGIC  -- creates a positive pulse every time current_count hits zero
                                       -- useful to enable another device, like to slow down a counter
              -- value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
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

distance <= dist3;

buzzer_downcounter_ins: buzzer_downcounter
 PORT map  ( clk => clk_in, 
				 distance => distance, 
              reset_n => reset_n,
              zero => zero
				  );

count_max <= "111111111";
duty_cycle <="011111111";
clk <= zero;
enable <= '1';
		
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
