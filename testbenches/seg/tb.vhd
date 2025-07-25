library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.finish;

entity tb is
end tb;

architecture sim of tb is

    constant clk_hz : integer := 100e6;
      constant clk_period : time := 1 sec / clk_hz;

      signal clk : std_logic := '1';
      signal rst : std_logic := '1';
      signal serial_in : std_logic := '0';
      signal serial_out : std_logic;
     
    begin

      clk <= not clk after clk_period / 2;

      DUT : entity work.shift_reg(rtl)
      port map (
        clk => clk,
        rst => rst,
        serial_in => serial_in,
        serial_out => serial_out
      );
    
      SEQUENCER_PROC : process
        constant test_pattern : std_logic_vector(31 downto 0) := x"ABCD1234";

      begin
        wait for 10 ns;
        rst <= '0';

        for i in 0 to 31 loop
          serial_in <= test_pattern(i);
          wait for clk_period * 1;
        end loop;
        
        wait;
      end process;

end architecture;