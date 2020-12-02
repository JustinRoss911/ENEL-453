library ieee;
use ieee.std_logic_1164.all;

ENTITY tb_Comparator IS
END tb_Comparator;

ARCHITECTURE behavior OF tb_Comparator IS

Signal reset_n,bool: std_logic;
Signal clk : std_logic := '0';
constant TbPeriod : time := 20 ns;
signal TbSimEnded : std_logic := '0';
Signal dist_in: std_logic_vector(12 downto 0); 

Component Comparator is
port ( reset_n    : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 dist_in    	:in std_logic_vector(12 downto 0); 
		 bool       :out std_logic
      );
end Component;

 begin 
    
    uut: Comparator port map ( 
			reset_n =>  reset_n,  
			clk => clk,
			dist_in => dist_in,
			bool => bool
			); 
			
	 clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
		
		reset_n <= '0';
		dist_in <= "1111111111111";
		
	  wait for 2*TbPeriod;
	  
	   reset_n <= '1';
		
	  wait for 2*TbPeriod; 
	  
	   dist_in <= "1010100100110";
	  
	  wait for 2*TbPeriod;
		  
		dist_in <= "1010100100100";
	  
	  wait for 2*TbPeriod;
	    
		reset_n <= '0';
		
	  wait for 2*TbPeriod;
	  
	   dist_in <= "0000000100100";
		
	  wait for 2*TbPeriod;
		  
		 reset_n <= '1';
		  
     wait;	-- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  

	end process;  
 
END;