library ieee;
use ieee.std_logic_1164.all;

entity tb_MUX4TO1 is
end tb_MUX4TO1;

architecture tb of tb_MUX4TO1 is

    component MUX4TO1
        port (in1     : in std_logic_vector (15 downto 0);
              in2     : in std_logic_vector (15 downto 0);
              in3     : in std_logic_vector (15 downto 0);
              in4     : in std_logic_vector (15 downto 0);
              s       : in std_logic_vector (1  downto 0);
              mux_out : out std_logic_vector (15 downto 0));
    end component;

    signal in1     : std_logic_vector (15 downto 0);
    signal in2     : std_logic_vector (15 downto 0);
    signal in3     : std_logic_vector (15 downto 0);
    signal in4     : std_logic_vector (15 downto 0);
    signal s       : std_logic_vector (1  downto 0);
    signal mux_out : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 20 ps; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : MUX4TO1
    port map (in1     => in1,
              in2     => in2,
              in3     => in3,
              in4     => in4,
              s       => s,
              mux_out => mux_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process -- Simulation is exactly 280ps long use this for ModelSim to show correct range.
    begin
		  assert false report "MUX4TO1 testbench started"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
        -- EDIT Adapt initialization as needed
        in1 <= (others => '0');
        in2 <= (others => '0');
        in3 <= (others => '0');
        in4 <= (others => '0');
        s <= (others => '0');

        -- EDIT Add stimuli here
		  wait for TbPeriod;
		  in1 <= "0000000000000000";
		  in2 <= "0000000000000000";
		  in3 <= "0000000000000000";
		  in4 <= "0101101001011010";
		  wait for TbPeriod;
		  s 	<= "00"; 
		  wait for TbPeriod;
		  in1 <= "0000000011110000";
		  in2 <= "0000000000001111";
		  in3 <= "0000000000111100";
		  wait for TbPeriod;
		  in1 <= "0000000000001111";
		  in2 <= "0000000011110000";
		  in3 <= "0000000011000011";
		  wait for TbPeriod;
		  s 	<= "01";
		  wait for TbPeriod; 
		  in1 <= "0000000010101010";
		  in2 <= "0000000001010101";
		  in3 <= "0000000011001100";
		  wait for TbPeriod;
		  in1 <= "0000000001010101";
		  in2 <= "0000000010101010";
		  in3 <= "0000000000110011";
		  wait for TbPeriod;
		  s 	<= "10"; 
		  wait for TbPeriod;
		  in1 <= "0000000000011000";
		  in2 <= "0000000011100111";
		  in3 <= "0000000010000001";
		  wait for TbPeriod;
		  in1 <= "0000000011100111";
		  in2 <= "0000000000011000";
		  in3 <= "0000000001111110";
		  wait for TbPeriod;
		  s 	<= "11"; 
		  wait for TbPeriod;
		  in1 <= "0000000011011101";
		  in2 <= "0000000000100010";
		  in3 <= "0000000011111111";
		  wait for TbPeriod;
		  in1 <= "0000000000100010";
        in2 <= "0000000011011101";-- Stop the clock and hence terminate the simulation
        in3 <= "0000000000000000";TbSimEnded <= '1';
		  wait for TbPeriod;
		  assert false report "MUX2TO1 testbench completed"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_MUX4TO1 of tb_MUX4TO1 is
    for tb
    end for;
end cfg_tb_MUX4TO1;


-- Jessica's tb code


--ENTITY tb_MUX4TO1 IS
--END tb_MUX4TO1;
--
--ARCHITECTURE behavior OF tb_MUX4TO1 IS
--
---- Component Declaration for the UUT
--
--   COMPONENT MUX4TO1 is
--	 port (in1     : in  std_logic_vector(15 downto 0); -- in1 = binary (hex)
--			 in2     : in  std_logic_vector(15 downto 0); -- in2 = decimal 
--			 in3     : in  std_logic_vector(15 downto 0); -- in3 = stored value 
--			 in4     : in  std_logic_vector(15 downto 0); -- in4 = 5A5A
--			 s       : in  std_logic_vector(1  downto 0); -- Switches that toggles between mode
--			 mux_out : out std_logic_vector(15 downto 0)  -- output bits 
--			);
--   end COMPONENT;   
--
--    signal   s                			  : std_logic_vector(1 downto 0);
--    signal   in1, in2, in3, in4, mux_out : std_logic_vector(15 downto 0);
--    constant time_delay      			     : time := 20 ps;
--    
-- 
--    begin 
--    -- Instantiate the Unit Under Test (UUT)
--    
--    uut: MUX4TO1 port map ( 
--					in1 		=>  in1,  
--					in2		=>  in2,
--					in3      =>  in3,
--					in4      =>  in4,
--					s 			=>  s,
--					mux_out  =>  mux_out
--					);
--			   
--    -- Stimulus process 
--      stim_process: process -- this process, in testbench/simulation code, is different than in design code
--      begin
--		  assert false report "MUX4TO1 testbench started"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
--		  wait for time_delay;
--		  in1 <= "0000000000000000"; 
--		  in2 <= "0000000000000000";
--		  in3 <= "0000000000000000";
--		  in4 <= "0101101001011010"; -- don't change to mimic code 
--        wait for time_delay;
--		  s <= "00"; 
--		  wait for time_delay;
--		  in1 <= "0000000011110000"; 
--		  in2 <= "0000000000001111";
--		  in3 <= "0000000000111100"; 
--        wait for time_delay;
--		  in1 <= "0000000000001111"; 
--		  in2 <= "0000000011110000";
--		  in3 <= "0000000011000011"; 
--        wait for time_delay;
--		  s <= "01";
--		  wait for time_delay; 
--		  in1 <= "0000000010101010"; 
--		  in2 <= "0000000001010101";
--		  in3 <= "0000000011001100"; 
--        wait for time_delay;
--		  in1 <= "0000000001010101"; 
--		  in2 <= "0000000010101010";
--		  in3 <= "0000000000110011"; 
--        wait for time_delay;
--		  s <= "10"; 
--		  wait for time_delay;
--		  in1 <= "0000000000011000"; 
--		  in2 <= "0000000011100111";
--		  in3 <= "0000000010000001"; 
--		  wait for time_delay;
--		  in1 <= "0000000011100111"; 
--		  in2 <= "0000000000011000";
--		  in3 <= "0000000001111110"; 
--		  s <= "11"; 
--		  wait for time_delay;
--		  in1 <= "0000000011011101"; 
--		  in2 <= "0000000000100010";
--		  in3 <= "0000000011111111"; 
--		  wait for time_delay;
--		  in1 <= "0000000000100010"; 
--		  in2 <= "0000000011011101";
--		  in3 <= "0000000000000000"; 
--		  wait for 10*time_delay; -- this extends the time by 10x the time_delay, for ease of veiwing waveforms
--		  assert false report "MUX2TO1 testbench completed"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
--        wait;	-- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  
--
--	   end process;  
-- 
--END;
