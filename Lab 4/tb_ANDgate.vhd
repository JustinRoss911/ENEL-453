library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ANDgate is
end tb_ANDgate;

architecture tb of tb_ANDgate is
Component ANDgate is
port ( C    : in  STD_LOGIC_vector(21 downto 0);
       factor : in  STD_LOGIC;
		 K :out std_logic_vector(21 downto 0)
      );
end Component;
	
	Signal factor: std_logic; 
	Signal C, K: std_logic_vector(21 downto 0);
	
begin 


    UUT : ANDgate
    port map (C     => C,
              factor => factor,
				  K     => K);
				  
				  					
    stim_process: process 
    begin

	factor <= '1';
	C <= "0000001111100001110010";
	
	wait for 20ns;
	
	C <= "1010101010101010101010";
	
	wait for 20ns;
	
	factor <= '0';
	
	wait for 20ns;
	
	C <= "1111111111111111111111";
	
	       
	wait;
    
	 end process; 

end tb;
		  