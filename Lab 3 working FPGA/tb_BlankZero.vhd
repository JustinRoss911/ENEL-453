-- finishes at 2500 ps

-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.11.2020 22:23:14 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_BlankZero is
end tb_BlankZero;

architecture tb of tb_BlankZero is

    component BlankZero
        port (Q     : in std_logic_vector (15 downto 0);
              s     : in std_logic_vector (1 downto 0);
              Blank : out std_logic_vector (5 downto 0));
    end component;

    signal Q     : std_logic_vector (15 downto 0);
    signal s     : std_logic_vector (1 downto 0);
    signal Blank : std_logic_vector (5 downto 0);
    constant time_delay		: time := 1 ps;

begin

    dut : BlankZero
    port map (Q     => Q,
              s     => s,
              Blank => Blank);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Q <= (others => '0');
        s <= (others => '0');

        -- EDIT Add stimuli here
		s <= "00"; -- mode 1
		Q <= "0000100101001000";  -- should output blank = "110000"
	wait for 100*time_delay;
		Q <= "0010100101111000";
	wait for 100*time_delay;
		Q <= "1101011010000111";
	wait for 100*time_delay;
		Q <= "0000011010000000";
	wait for 100*time_delay;
		Q <= "0000000000110111";
	wait for 100*time_delay;
		Q <= "0000000000000101";
	wait for 100*time_delay;
		s <= "01"; -- mode 2
		Q <= "0000100101001000";  
	wait for 100*time_delay;
		Q <= "0010100101111000";  -- should output blank = "110000"
	wait for 100*time_delay;
		Q <= "1101011010000111";
	wait for 100*time_delay;
		Q <= "0000011010000000";
	wait for 100*time_delay;
		Q <= "0000000000110111";
	wait for 100*time_delay;
		Q <= "0000000000000101";
	wait for 100*time_delay;
		s <= "10"; -- mode 3
		Q <= "0000100101001000";  
	wait for 100*time_delay;
		Q <= "0010100101111000";
	wait for 100*time_delay;
		Q <= "1101011010000111";
	wait for 100*time_delay;
		Q <= "0000011010000000";
	wait for 100*time_delay;
		Q <= "0000000000110111";
	wait for 100*time_delay;
		Q <= "0000000000000101";
	wait for 100*time_delay;
		s <= "11"; -- mode 4
		Q <= "0000100101001000";  -- should output blank = "111000"
	wait for 100*time_delay;
		Q <= "0010100101111000";
	wait for 100*time_delay;
		Q <= "1101011010000111";
	wait for 100*time_delay;
		Q <= "0000011010000000";
	wait for 100*time_delay;
		Q <= "0000000000110111";
	wait for 100*time_delay;
		Q <= "0000000000000101";

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_BlankZero of tb_BlankZero is
    for tb
    end for;
end cfg_tb_BlankZero;
