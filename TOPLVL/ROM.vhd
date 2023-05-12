--Memória ROM com 16 endereços de 18 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ROM is
    port(   clk: in std_logic;
            endereco : in unsigned(7 downto 0);
            dado: out unsigned(17 downto 0)
    );
end entity;
architecture a_ROM of ROM is
    type mem is array (0 to 127) of unsigned(17 downto 0);
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => "010100000000000101",
        1 => "010000000000000011",
        2 => "100000000000000000",
        3 => "010100000000001000",
        4 => "010000000000000100",
        5 => "000100000000000100",
        6 => "000100000000000011",
        7 => "010000000000000101",
        8 => "101100000000000001",
        9 => "001100000000001101",
        10 => "000000000000001010",
		11 => "000000000000000011",
        12 => "100000000000000000",
        13 => "000100000000001101",
        14 => "010000000000000011",
		15 => "001100000000000101",
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