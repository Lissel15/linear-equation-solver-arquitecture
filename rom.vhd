library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
Port(
    addr  : in STD_LOGIC_VECTOR(31 downto 0);
    instr : out STD_LOGIC_VECTOR(31 downto 0)
);
end rom;

architecture arch of rom is
    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
    signal rom_mem : rom_type := (
        0 => x"00000001", -- Ec 1
        1 => x"00000002", -- Ec 2
        2 => x"00000003", -- Ec 3
        3 => x"00000004", -- Ec 4
        others => x"00000000"
    );
begin
    instr <= rom_mem(to_integer(unsigned(addr(7 downto 2))));
end arch;
