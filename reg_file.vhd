library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity reg_file is

Port(

    clk : in STD_LOGIC;


    regWrite : in STD_LOGIC;


    rs1 : in STD_LOGIC_VECTOR(4 downto 0);

    rs2 : in STD_LOGIC_VECTOR(4 downto 0);

    rd  : in STD_LOGIC_VECTOR(4 downto 0);


    wd : in STD_LOGIC_VECTOR(31 downto 0);


    rd1 : out STD_LOGIC_VECTOR(31 downto 0);

    rd2 : out STD_LOGIC_VECTOR(31 downto 0)

);

end reg_file;


architecture arch of reg_file is


    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);


    signal regs : reg_array := (


        1 => x"00000002",

        2 => x"00000004",


        3 => x"00000005",

        4 => x"FFFFFFF6",


        5 => x"00000003",

        6 => x"00000009",


        7 => x"00000004",

        8 => x"FFFFFFF8",


        others => (others => '0')


    );


begin


    rd1 <= regs(to_integer(unsigned(rs1)))

        when rs1 /= "00000"

        else (others => '0');


    rd2 <= regs(to_integer(unsigned(rs2)))

        when rs2 /= "00000"

        else (others => '0');


    process(clk)

    begin


        if falling_edge(clk) then


            if regWrite = '1' and rd /= "00000" then


                regs(to_integer(unsigned(rd))) <= wd;


            end if;


        end if;


    end process;


end arch;
