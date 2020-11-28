-- Calculates the moving average of 256 samples of 12-bit data
-- Authors: Dan Tran and Ranbir Briar, ENEL 453 students F2019

-- Note, use Q_high_res if you need it. Uncomment in 3 places.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity averager256 is
   generic( -- Note, these are the generic default values. The actual values are in the instantiation generic map.
	     N    : INTEGER := 8; -- 8; -- log2(number of samples to average over), e.g. N=8 is 2**8 = 256 samples 
        X    : INTEGER := 4; -- X = log4(2**N), e.g. log4(2**8) = log4(4**4) = log4(256) = 4 (bit of resolution gained)
		  bits : INTEGER := 11 -- number of bits in the input data to be averaged
		  );    
   port (
        clk     : in  std_logic;
        EN      : in  std_logic; -- takes a new sample when high for each clock cycle
        reset_n : in  std_logic; -- active-low
        Din     : in  std_logic_vector(bits downto 0); -- input sample for moving average calculation
        Q       : out std_logic_vector(bits downto 0)  -- 12-bit moving average of 256 samples
        -- Q_high_res :  out std_logic_vector(X+bits downto 0) -- (4+11 downto 0) -- first add (i.e. X) must match X constant in ADC_Data  
        );                                                -- moving average of ADC with additional bits of resolution:
   end averager256;                                       -- 256 average can give an additional 4 bits of ADC resolution, depending on conditions
                                                          -- so you get 12-bits plus 4-bits = 16-bits (is this real?)
architecture rtl of averager256 is

-- Declaring new data types -----
subtype REG is std_logic_vector(bits downto 0);  -- REG is vector of 12 bits
type Register_Array is array (natural range <>) of REG; -- Register_Array is an array of infinite REG vectors. Data type is positive integers only. 
type temporary is array(integer range <>) of integer; -- temporary is an array of integers with infinite length

-- Declaring signals -----
signal REG_ARRAY : Register_Array(2**N downto 1); -- REG_ARRAY is a register array with 256 rows 
signal tmp : temporary((2**N)-1 downto 1); -- tmp is an integer array with 255 rows
signal tmplast : std_logic_vector(2**N-1 downto 0); -- tmplast is a vector with 255 bits 
constant Zeros : STD_LOGIC_VECTOR(11 downto 0) := (others => '0'); -- vector of 12 zeros 

begin

   shift_reg : process(clk, reset_n)
   begin
      if(reset_n = '0') then -- active low
      
         LoopA1: for i in 1 to 2**N loop -- for i = 1:256
            REG_ARRAY(i) <= Zeros; -- fill entire array with zeros 
         end loop LoopA1;
         Q          <= (others => '0'); -- all ouput bits set to 0 
         -- Q_high_res <= (others => '0');
         
      elsif rising_edge(clk) then 
         if EN = '1' then 
         
            REG_ARRAY(1) <= Din;
            LoopA2: for i in 1 to 2**N-1 loop --for i = 1:255
               REG_ARRAY(i+1) <= REG_ARRAY(i); -- assign Din to every row? 
            end loop LoopA2;
            Q          <= tmplast(N+bits downto N); -- Q = tmplast(19 downto 8)
            -- Q_high_res <= tmplast(N+bits downto N-X);
            
         end if;
      end if;
   end process shift_reg;
   

add_reg : process(clk, EN)
	begin
	LoopB1: for i in 1 to (2**N)/2 loop -- for i = 1:128
		if EN = '1' then
			if rising_edge(clk) then
				tmp(i) <= to_integer(unsigned(REG_ARRAY((2*i)-1)))  + to_integer(unsigned(REG_ARRAY(2*i))); -- add adjacent registers and store in temp array
			end if;
		end if;
	end loop LoopB1;


	LoopB2: for i in ((2**N)/2)+1 to (2**N)-1 loop -- for i = 129:255
		if EN = '1' then
			if rising_edge(clk) then
				tmp(i) <= tmp(2*(i-(2**N)/2)-1) + tmp(2*(i-(2**N)/2)); -- add adjacent vectors in tmp and store in lower half of tmp
			end if;
		end if;
	end loop LoopB2;
end process add_reg;
   
   tmplast <= std_logic_vector(to_unsigned(tmp((2**N)-1), tmplast'length)); -- choose last row of tmp 
      
end rtl;
