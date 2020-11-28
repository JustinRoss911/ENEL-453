library ieee;
use ieee.std_logic_1164.all;

ENTITY tb_DPmux IS
END tb_DPmux;

ARCHITECTURE behavior OF tb_DPmux IS

-- Component Declaration for the UUT

   COMPONENT DPmux is
		port ( 
		 dp1 	  : in  std_logic_vector(5 downto 0);
		 dp2	  : in  std_logic_vector(5 downto 0);
		 dp3	  : in  std_logic_vector(5 downto 0);
		 dp4	  : in  std_logic_vector(5 downto 0);
		 s      : in  std_logic_vector(1 downto 0); 
       dp_out : out std_logic_vector(5 downto 0)  
      );
   end COMPONENT;   

    signal   s                			  : std_logic_vector(1 downto 0);
    signal   dp1, dp2, dp3, dp4, dp_out  : std_logic_vector(5 downto 0);
    constant time_delay      			     : time := 20 ps;
    
 
    begin 
    -- Instantiate the Unit Under Test (UUT)
    
    uut: DPmux port map ( 
					dp1 		=>  dp1,  
					dp2		=>  dp2,
					dp3      =>  dp3,
					dp4      =>  dp4,
					s 			=>  s,
					dp_out  =>  dp_out
					);
			   
    -- Stimulus process 
      stim_process: process -- this process, in testbench/simulation code, is different than in design code
      begin
		  dp1 <= "000000";
		  dp2 <= "111111";
		  dp3 <= "010101";
		  dp4 <= "101010";
		  wait for 100*time_delay; 
		  s <= "00"; 
		  wait for 100*time_delay;
		  dp1 <= "000111";
		  dp2 <= "111000";
		  dp3 <= "111111";
		  dp4 <= "000000";
        wait for 100*time_delay;
		  s <= "01"; 
		  wait for 100*time_delay;
		  dp1 <= "101010";
		  dp2 <= "000111";
		  dp3 <= "111111";
		  dp4 <= "001100";
        wait for 100*time_delay;
		  s <= "10";
		  wait for 100*time_delay; 
	     dp1 <= "010101";
		  dp2 <= "001100";
		  dp3 <= "000000";
		  dp4 <= "110011";
		  wait for 100*time_delay;
		  s <= "11";
		  wait for 100*time_delay;
		  dp1 <= "101010";
		  dp2 <= "110011";
		  dp3 <= "111000";
		  dp4 <= "000011";
		  wait for 10*time_delay; -- this extends the time by 10x the time_delay, for ease of veiwing waveforms
		 
        wait;	-- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  

	   end process;  
 
END;
