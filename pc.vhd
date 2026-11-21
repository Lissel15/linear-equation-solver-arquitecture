library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc is
Port(
    clk : in STD_LOGIC;
    pc_out : out STD_LOGIC_VECTOR(31 downto 0)
);
end pc;

architecture arch of pc is
    -- Inicializar a 0 es CLAVE para que no salga la línea roja
    signal pc_reg : integer := 0;
begin
    process
    begin
        loop
            wait until clk = '1';
            pc_reg <= pc_reg + 4;
            wait until clk = '0';
        end loop;
    end process;

    pc_out <= std_logic_vector(to_unsigned(pc_reg, 32));
end arch;
