library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_DutyControl is
end tb_DutyControl;

architecture tb of tb_DutyControl is
Component DutyControl is
 port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 input_dist :in std_logic_vector(12 downto 0); 
		 set_duty   :out std_logic_vector(8 downto 0)
      );
end component;
	
	Signal reset_n: std_logic;
	Signal clk : std_logic := '0';
	Signal input_dist: STD_LOGIC_VECTOR(12 downto 0); 
	Signal set_duty: STD_LOGIC_VECTOR(8 downto 0); 
	constant TbPeriod : time := 20 ns;
   signal TbSimEnded : std_logic := '0';
	
	
begin

    UUT : DutyControl
    Port Map (reset_n  => reset_n,
               clk      => clk, 
               input_dist  => input_dist, 
				   set_duty 		=> set_duty
           );

				  
	 -- Clock generation
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
	  
	 -- Initialization
			
	 
		  reset_n <= '0'; -- reset (put everything in a known state) 
		  input_dist <= "1010000010110";

		  wait for 2*TbPeriod;
		  
		  reset_n <= '1';
		  
		  wait for 2*TbPeriod;
		  
		  input_dist <= "0010000010000";
		  
		  wait for 2*TbPeriod;
		  
		  input_dist <= "0010000010000";
		  
		  wait for 2*TbPeriod;
		  
		  input_dist <= "0000011100000";
		  
		  wait for 2*TbPeriod;
		  
		  input_dist <= "0000000000001";
		  
		  wait for 2*TbPeriod;
		  
		  input_dist <= "0000000000000";
        
		  wait;
    
	 end process;

end tb;
		  
		  