library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity alu is

Port(

    a    : in STD_LOGIC_VECTOR(31 downto 0);

    b    : in STD_LOGIC_VECTOR(31 downto 0);


    ctrl : in STD_LOGIC_VECTOR(3 downto 0);


    res  : out STD_LOGIC_VECTOR(31 downto 0)

);

end alu;


architecture arch of alu is

begin


    process(a,b,ctrl)


        variable ai : integer;

        variable bi : integer;


        variable x  : integer;


    begin


        ai := to_integer(signed(a));

        bi := to_integer(signed(b));


        case ctrl is


            -- ECUACION LINEAL

            when "0010" =>


                if ai /= 0 then


                    x := (-bi)/ai;


                else


                    x := 0;


                end if;


            when others =>


                x := 0;


        end case;


        res <= std_logic_vector(

            to_signed(x,32)

        );


    end process;


end arch;
