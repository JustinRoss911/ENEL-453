library ieee;
use ieee.std_logic_1164.all;

ENTITY tb_inverter IS
END tb_inverter;

ARCHITECTURE behavior OF tb_inverter IS

Signal B: std_logic;
Signal Y: std_logic;

Component Inverter is
port ( B : in std_logic;
		 Y : out std_logic
      );
end Component;

 begin 
    
    uut: Inverter port map ( 
			B =>  B,  
			Y => Y
			); 
					
    stim_process: process 
    begin
	 
		B <= '0';
		
	  wait for 20ns;
	  
		B <= '1'; 
	  
	  wait for 20ns;
		  
		 B <= '0'; 
	  
	  wait for 20ns;
		  
		 B <= '1'; 
	  
	  wait for 20ns;
		  
     wait;	-- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  

	  end process;  
 
END;