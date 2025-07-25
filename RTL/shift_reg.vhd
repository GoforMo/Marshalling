library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg is
  port (
    clk : in std_logic;
    rst : in std_logic;
    serial_in : in std_logic;
    serial_out : out std_logic
  );
end shift_reg;

architecture rtl of shift_reg is

  constant sreg_length : integer := 32;
  signal slv : std_logic_vector(sreg_length - 2 downto 0);

begin

  SREG_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        -- slv <= (others => '0');
        
      else

        slv <= serial_in & slv(slv'high downto 1);
        serial_out <= slv(0);
        
      end if;
    end if;
  end process;

end architecture;
