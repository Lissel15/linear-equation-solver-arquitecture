library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity tb is
end tb;

architecture sim of tb is
    signal clk : STD_LOGIC := '0';
    signal alu_res_tb, pc_out_tb, instr_tb : STD_LOGIC_VECTOR(31 downto 0);
    file fout : text open write_mode is "salida.txt";
begin
    uut : entity work.cpu port map(clk, alu_res_tb, pc_out_tb, instr_tb);

    -- Reloj con inicio forzado en '0'
    process
    begin
        clk <= '0'; wait for 10 ns;
        loop
            clk <= '1'; wait for 10 ns;
            clk <= '0'; wait for 10 ns;
        end loop;
    end process;

    -- Escritor de resultados
    process(clk)
        variable L : line;
    begin
        if rising_edge(clk) then
            write(L, to_integer(signed(alu_res_tb)));
            writeline(fout, L);
        end if;
    end process;
end sim;
