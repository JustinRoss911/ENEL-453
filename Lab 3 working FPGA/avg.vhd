library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity avg is
   port (
        clk     : in  std_logic;
        EN      : in  std_logic; -- takes a new sample when high for each clock cycle
        reset_n : in  std_logic; -- active-low
        Din     : in  std_logic_vector(11 downto 0); -- input sample for moving average calculation
        Q       : out std_logic_vector(11 downto 0)  -- 12-bit moving average of 256 samples
        -- Q_high_res :  out std_logic_vector(X+bits downto 0) -- (4+11 downto 0) -- first add (i.e. X) must match X constant in ADC_Data  
        );                                                -- moving average of ADC with additional bits of resolution:
   end avg;        

architecture behaviour of avg is

Signal input: std_logic_vector(11 to 0);
signal output : std_logic_vector(11 to 0);

	Component stored_value is 
		Port ( 
				D     				: in  std_logic_vector(11 downto 0); -- output of synchronizer 
				EN, reset_n, clk  : in  std_logic;							-- EN is ouput of debounce 				  
				Q     				: out std_logic_vector(11 downto 0)  -- input to mux 
				);
	END Component;
	
	reg: stored_value 
	Port MAP ( 
		 D  		=> Din,
		 EN 		=> EN, 
		 reset_n => reset_n,
		 clk		=> clk,    				  
		 Q 		=> Q    				
		 );

--	begin 
--	   Gen : for i in 1 to 3 generate
--         reg: stored_value
--			port map
--              (input(i), 
--				  EN, 
--				  reset_n,
--				  clk, 
--				  output(i+1));
--         end generate;
			
end behaviour 

--
--  component REG
--    port(D,CLK,RESET : in  std_ulogic;
--         Q           : out std_ulogic);
--  end component;
--begin
--   Reg_array: 
--   for i in 1 to 256 generate
--      reg : stored_value 
--		port map (
--			input(i), 
--			clk, 
--			reset_n, 
--			output(i+1));
--   end generate Reg_array;
--end GEN;
--	
--
--CreateRegisters: for i in 1 to 256 generate 
--	stored_value_0: stored_value 
--	Port MAP ( 
--		 D  		=> D,
--		 EN 		=> EN, 
--		 reset_n => reset_n,
--		 clk		=> clk,    				  
--		 Q 		=> Q    				
--		 );
--		 
--		 
--		 LoopB1: for i in 1 to (2**N)/2 generate -- for i = 1:128
--      tmp(i) <= to_integer(unsigned(REG_ARRAY((2*i)-1)))  + to_integer(unsigned(REG_ARRAY(2*i))); -- add adjacent registers and store in temp array 
--   end generate LoopB1;
--	
--	
--	entity D_FF is
--port (D,CLK_S : in BIT;
--      Q : out BIT := '0';
--      NQ : out BIT := '1' );
--end entity D_FF;
--architecture A_RS_FF of D_FF is
--begin
--BIN_P_RS_FF: process(CLK_S)
--   begin
--     if CLK_S = '1' and CLK_S'Event
--        then Q <= D;
--          NQ <= not D;
--     end if;
--  end process;
--end architecture A_RS_FF;
--
--entity COUNTER_BIN_N is
--generic (N : Integer := 4);
--port (Q : out Bit_Vector (0 to N-1);
--      IN_1 : in Bit );
--end entity COUNTER_BIN_N;
--architecture BEH of COUNTER_BIN_N is
--component D_FF
--  port(D, CLK_S : in BIT; Q, NQ : out BIT);
--end component D_FF;
--signal S : BIT_VECTOR(0 to N);
--begin
--   S(0) <= IN_1;
--   G_1 : for I in 0 to N-1 generate
--         D_Flip_Flop :
--         D_FF port map
--              (S(I+1), S(I), Q(I), S(I+1));
--         end generate;
--end architecture BEH;