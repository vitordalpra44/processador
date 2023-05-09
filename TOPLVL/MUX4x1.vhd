library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX4x1 is
    port( ope1: in unsigned(15 downto 0);
          ope2: in unsigned(15 downto 0);
          ope3: in unsigned(15 downto 0);
          ope4: in unsigned(15 downto 0); 
          sel : in unsigned(1 downto 0);
          saida: out unsigned(15 downto 0));
end entity;


architecture a_MUX4x1 of MUX4x1 is
begin
    saida <= ope1 when sel="00" else
             ope2 when sel="01" else
             ope3 when sel="10" else
             ope4 when sel="11" else
            "0000000000000000";
end architecture;

