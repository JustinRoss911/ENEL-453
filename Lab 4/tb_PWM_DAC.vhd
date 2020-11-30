library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_PWM_DAC is
end tb_PWM_DAC;

architecture tb of tb_PWM_DAC is
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
	
	Signal reset_n, enable, pwm_out: std_logic;
	Signal clk : std_logic := '0';
	Signal count_max: STD_LOGIC_VECTOR(8 downto 0); 
	Signal duty_cycle: STD_LOGIC_VECTOR(8 downto 0); 
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : PWM_DAC
	 Generic Map (width => 9)
    Port Map (reset_n  => reset_n,
               clk      => clk, 
				   count_max  => count_max,
               duty_cycle  => duty_cycle, 
				   enable 		=> enable, 
               pwm_out  => pwm_out  
           );

				  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; -- reset (put everything in a known state) 
		  enable <= '0';
		  duty_cycle <= "011111111";
		  count_max  <= "111111111";

		  wait for 2*TbPeriod;
		  
		  reset_n <= '1';
		  
		  wait for 2*TbPeriod;
		  
		  enable <= '1';
		  
		  wait for 5000*TbPeriod;
		  
		  TbSimEnded <= '1';
        
		  wait;
    
	 end process;

end tb;
		  
		  