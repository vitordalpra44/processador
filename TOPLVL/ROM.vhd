--Memória ROM com 16 endereços de 18 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ROM is
    port(   clk: in std_logic;
            endereco : in unsigned(3 downto 0);
            dado: out unsigned(17 downto 0)
    );
end entity;
architecture a_ROM of ROM is
    type mem is array (0 to 15) of unsigned(17 downto 0);
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => "001100000000001001",
        1 => "001100000000000011",
        2 => "000000000000000010",
        3 => "000000000000000011",
        4 => "000000000000000100",
        5 => "000000000000000101",
        6 => "000000000000000110",
        7 => "000000000000000111",
        8 => "000000000000001000",
        9 => "000000000000001001",
        10 =>"000000000000001010",
        -- abaixo: casos omissos => (zero em todos os bits)
        others => (others=>'0')
    );
    begin
    process(clk)
        begin
            if(rising_edge(clk)) then
                dado <= conteudo_rom(to_integer(endereco));
            end if;
    end process;
end architecture;