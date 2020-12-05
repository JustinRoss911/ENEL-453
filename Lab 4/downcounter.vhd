library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity downcounter is    
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enab  : in  STD_LOGIC; -- active-high enable (I don't know what the purpose of enable is in this module) 
              zero    : out STD_LOGIC;  -- creates a positive pulse every time current_count hits zero
              period :in std_logic_vector(15 downto 0)                         -- useful to enable another device, like to slow down a counter
              --value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         );
end downcounter;

architecture Behavioral of downcounter is
   signal current_count : integer;

BEGIN
   
   downcount : process(clk,reset_n) begin
     if (reset_n = '0') then 
          current_count <= 0 ;
          zero          <= '0';	
     elsif (rising_edge(clk)) then -- if clock is on a rising edge AND enable = 1
        if (enab = '1') then 
           if (current_count = 0) then -- Each time decrease current_count. Once current_count gets to zero reset it to the period-1 
             current_count <= to_integer(unsigned(period)) - 1; 
             zero          <= '1'; -- if current count is at 0, set zero = 1 (active) 
           else 
             current_count <= current_count - 1; 
             zero          <= '0';
           end if;
        else 
           zero <= '0'; -- if eneable = 0 set zero to 0 
        end if;
     end if;
   end process;
   
   -- value <= std_logic_vector(to_signed(current_count, value'length)); -- helps output the current_count value, if needed
   
END Behavioral;
