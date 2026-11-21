library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity cpu is

Port(

    clk : in STD_LOGIC;


    alu_out_test : out STD_LOGIC_VECTOR(31 downto 0);

    pc_out_test  : out STD_LOGIC_VECTOR(31 downto 0);

    instr_test   : out STD_LOGIC_VECTOR(31 downto 0)

);

end cpu;


architecture arch of cpu is


    signal pc_out : STD_LOGIC_VECTOR(31 downto 0);


    signal instr : STD_LOGIC_VECTOR(31 downto 0);


    signal rd1 : STD_LOGIC_VECTOR(31 downto 0);

    signal rd2 : STD_LOGIC_VECTOR(31 downto 0);


    signal alu_res : STD_LOGIC_VECTOR(31 downto 0);


    signal regWrite : STD_LOGIC;


    signal alu_ctrl : STD_LOGIC_VECTOR(3 downto 0);


    signal rs1 : STD_LOGIC_VECTOR(4 downto 0);

    signal rs2 : STD_LOGIC_VECTOR(4 downto 0);


begin


    U1 : entity work.pc

    port map(

        clk,

        pc_out

    );


    U2 : entity work.rom

    port map(

        pc_out,

        instr

    );


    U3 : entity work.control_unit

    port map(

        instr(6 downto 0),

        regWrite,

        alu_ctrl

    );


    process(instr)

    begin


        case instr is


            when x"00000001" =>

                rs1 <= "00001";

                rs2 <= "00010";


            when x"00000002" =>

                rs1 <= "00011";

                rs2 <= "00100";


            when x"00000003" =>

                rs1 <= "00101";

                rs2 <= "00110";


            when x"00000004" =>

                rs1 <= "00111";

                rs2 <= "01000";


            when others =>

                rs1 <= "00000";

                rs2 <= "00000";


        end case;


    end process;


    U4 : entity work.reg_file

    port map(

        clk,

        regWrite,


        rs1,

        rs2,


        "00000",


        alu_res,


        rd1,

        rd2

    );


    U5 : entity work.alu

    port map(

        rd1,

        rd2,

        alu_ctrl,

        alu_res

    );


    alu_out_test <= alu_res;

    pc_out_test  <= pc_out;

    instr_test   <= instr;


end arch;
