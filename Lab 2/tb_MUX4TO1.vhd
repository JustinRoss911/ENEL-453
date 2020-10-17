library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_MUX4TO1 IS
END tb_MUX4TO1;

ARCHITECTURE behavior OF tb_MUX4TO1 IS

-- Component Declaration for the UUT

   COMPONENT MUX4TO1 is
	 port (in1     : in  std_logic_vector(15 downto 0); -- in1 = binary (hex)
			 in2     : in  std_logic_vector(15 downto 0); -- in2 = decimal 
			 in3     : in  std_logic_vector(15 downto 0); -- in3 = stored value 
			 in4     : in  std_logic_vector(15 downto 0); -- in4 = 5A5A
			 s       : in  std_logic_vector(1  downto 0); -- Switches that toggles between mode
			 mux_out : out std_logic_vector(15 downto 0)  -- output bits 
			);
   end COMPONENT;   

    signal   s                			  : std_logic_vector(1 downto 0);
    signal   in1, in2, in3, in4, mux_out : std_logic_vector(15 downto 0);
    constant time_delay      			     : time := 20 ps;
    
 
    begin 
    -- Instantiate the Unit Under Test (UUT)
    
    uut: MUX4TO1 port map ( 
					in1 		=>  in1,  
					in2		=>  in2,
					in3      =>  in3,
					in4      =>  in4,
					s 			=>  s,
					mux_out  =>  mux_out
					);
			   
    -- Stimulus process 
      stim_process: process -- this process, in testbench/simulation code, is different than in design code
      begin
		  assert false report "MUX4TO1 testbench started"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
		  wait for time_delay;
		  in1 <= "0000000000000000"; 
		  in2 <= "0000000000000000";
		  in3 <= "0000000000000000";
		  in4 <= "0101101001011010"; -- don't change to mimic code 
        wait for time_delay;
		  s <= "00"; 
		  wait for time_delay;
		  in1 <= "0000000011110000"; 
		  in2 <= "0000000000001111";
		  in3 <= "0000000000111100"; 
        wait for time_delay;
		  in1 <= "0000000000001111"; 
		  in2 <= "0000000011110000";
		  in3 <= "0000000011000011"; 
        wait for time_delay;
		  s <= "01";
		  wait for time_delay; 
		  in1 <= "0000000010101010"; 
		  in2 <= "0000000001010101";
		  in3 <= "0000000011001100"; 
        wait for time_delay;
		  in1 <= "0000000001010101"; 
		  in2 <= "0000000010101010";
		  in3 <= "0000000000110011"; 
        wait for time_delay;
		  s <= "10"; 
		  wait for time_delay;
		  in1 <= "0000000000011000"; 
		  in2 <= "0000000011100111";
		  in3 <= "0000000010000001"; 
		  wait for time_delay;
		  in1 <= "0000000011100111"; 
		  in2 <= "0000000000011000";
		  in3 <= "0000000001111110"; 
		  s <= "11"; 
		  wait for time_delay;
		  in1 <= "0000000011011101"; 
		  in2 <= "0000000000100010";
		  in3 <= "0000000011111111"; 
		  wait for time_delay;
		  in1 <= "0000000000100010"; 
		  in2 <= "0000000011011101";
		  in3 <= "0000000000000000"; 
		  wait for 10*time_delay; -- this extends the time by 10x the time_delay, for ease of veiwing waveforms
		  assert false report "MUX2TO1 testbench completed"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
        wait;	-- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  

	   end process;  
 
END;
