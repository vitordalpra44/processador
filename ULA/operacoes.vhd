library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operacoes is
    port( val0: in unsigned(15 downto 0);
          val1: in unsigned(15 downto 0);
          soma: out unsigned(15 downto 0);
          subtracao: out unsigned(15 downto 0); 
          maior_que : out unsigned(15 downto 0);
          multiplicacao: out unsigned(15 downto 0));

end entity;


architecture a_operacoes of operacoes is
signal soma_ext: unsigned (16 downto 0);
signal multip_ext: unsigned (31 downto 0);
begin
	soma_ext <= ('0' & val0) + val1;
    soma <= soma_ext(15 downto 0);
    subtracao <= val0-val1;
    maior_que<= "0000000000000001" when val0>val1 else
                "0000000000000000" when val0<=val1 else
                "0000000000000000" ;
	multip_ext <= val0 * val1;
    multiplicacao <= multip_ext (15 downto 0); 
end architecture;

        