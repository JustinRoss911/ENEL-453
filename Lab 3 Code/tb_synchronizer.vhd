library ieee;
use ieee.std_logic_1164.all;

entity tb_synchronizer is
end tb_synchronizer;

architecture tb of tb_synchronizer is

component synchronizer
    port (A: 				in		std_logic_vector (9 downto 0);
			 clk, reset_n: in		std_logic;
          G: 				out	std_logic_vector (9 downto 0));
end component;

signal A   : std_logic_vector (9 downto 0);
signal clk, reset_n : std_logic;
signal G   : std_logic_vector (9 downto 0);

constant TbPeriod : time := 20 ps; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';

begin

    dut : synchronizer
    port map (A   => A,
              clk => clk,
                  reset_n => reset_n,
              G   => G);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        A <= "0000000000";
          reset_n <= '1';

        -- EDIT Add stimuli here
        wait for TbPeriod;
          A <= "1010101010"; -- Arbitrary 0's and 1's showing which swtiches are on and off.
          wait for TbPeriod;
          A <= "0101010101";
          reset_n <= '0';
          wait for 2*TbPeriod; -- period * 2 to ensure enough clock cycles have occured to copy over the most recent signal A.
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;