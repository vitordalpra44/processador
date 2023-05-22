library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OPERACOES is
    port( val0          :in unsigned(15 downto 0);
          val1          :in unsigned(15 downto 0);
          carry_subtr    :out std_logic;
          carry_soma    :out std_logic;
          soma          :out unsigned(15 downto 0);
          subtracao     :out unsigned(15 downto 0); 
          maior_que     :out unsigned(15 downto 0);
          multiplicacao :out unsigned(15 downto 0));

end entity;


architecture a_OPERACOES of OPERACOES is
signal soma_ext: unsigned (16 downto 0);
signal multip_ext: unsigned (31 downto 0);
begin
	soma_ext <= ('0' & val0) + val1;
    soma <= soma_ext(15 downto 0);
    subtracao <= val0-val1;
    carry_soma <= soma_ext (16);
    carry_subtr <=  '0' when val1 <= val0 else
                    '1';
    maior_que<= "0000000000000001" when val0>val1 else
                "0000000000000000" when val0<=val1 else
                "0000000000000000" ;
	multip_ext <= val0 * val1;
    multiplicacao <= multip_ext (15 downto 0); 
end architecture;

        