library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX2x1 is
    port( sinal1    :in unsigned(15 downto 0);
          sinal2    :in unsigned(15 downto 0);
		  sel       :in std_logic;
          saida     :out unsigned(15 downto 0)
		);
end entity;


architecture a_MUX2x1 of MUX2x1 is
begin
    saida <= sinal1 when sel= '0' else
             sinal2 when sel= '1' else
            "0000000000000000";
end architecture;

