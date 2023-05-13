--Memória ROM com 16 endereços de 18 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ROM is
    port(   clk: in std_logic;
            endereco : in unsigned(6 downto 0);
            dado: out unsigned(17 downto 0)
    );
end entity;
architecture a_ROM of ROM is
    type mem is array (0 to 127) of unsigned(17 downto 0);
    constant conteudo_rom : mem := (
        -- caso endereco => conteudo
        0 => "100000000000000101",
        1 => "010100000000000011",
        2 => "100000000000001000",
        3 => "010100000000000100",
        4 => "110100000000000011",
        5 => "000100000000000100",
        6 => "010100000000000101", -- ponto do jump
        7 => "101000000000000001",
        8 => "010100000000000101",
        9 => "011000000000010100",
        10 => "000000000000001010",
		11 => "000000000000000011",
        12 => "000000000000000000",
        13 => "000100000000001101",
        14 => "010000000000000011",
		15 => "001100000000000101",
        16 => "000000000000001010",
		17 => "000000000000000011",
        18 => "100000000000000000",
        19 => "000100000000001101",
        20 => "110100000000000101",
		21 => "010100000000000011",
        22 => "011100000000000110", -- jump de retorno
		23 => "001100000000000101",
        24 => "010000000000000011",
		25 => "001100000000000101",
        26 => "010000000000000011",
		27 => "001100000000000101",
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