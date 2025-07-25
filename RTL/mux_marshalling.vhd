library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_marshalling is
  port (
    clk : in std_logic;
    rst : in std_logic;
    serial_in : in std_logic;
    byte_out : out std_logic_vector(7 downto 0)
  );
end mux_marshalling;

architecture rtl of mux_marshalling is

  signal slv : std_logic_vector(7 downto 0);
  signal cnt : unsigned(2 downto 0);

begin

  MUX_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        byte_out <= (others => '0');
        slv <= (others => '0');
        cnt <= (others => '0');

      else

        slv(to_integer(cnt)) <= serial_in;
        cnt <= cnt + 1;
        
        if cnt = 0 then
          byte_out <= slv;
        end if;
        
      end if;
    end if;
  end process;

end architecture;