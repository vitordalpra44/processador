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
        0 =>  "000000000000000000",
        1 =>  "100000000000001010", -- LDA 10
        2 =>  "010100000000000010", -- STA 2
        3 =>  "111100000000101010", -- STOREMEM 2 5
        4 =>  "000000000000000000", 
        5 =>  "000000000000000000", 
        6 =>  "111000000000101001", -- LOADMEM 2 1
        7 =>  "100000000000000101", -- LDA 5
        8 =>  "010100000000000101", -- STA 5
        9 =>  "111100000000001101", -- STOREMEM 1 5
        10 => "010100000000000110", -- STA 6
		11 => "111100000001101110", -- STOREMEM 13 6
        12 => "000000000000000000", 
        13 => "000000000000000000", 
        14 => "000000000000000000",
		15 => "000000000000000000",
        16 => "000000000000000000",
		17 => "000000000000000000",
        18 => "000000000000000000",
        19 => "000000000000000000",
        20 => "000000000000000000",
		21 => "000000000000000000",
        22 => "000000000000000000",
		23 => "000000000000000000",
        24 => "000000000000000000",
		25 => "000000000000000000",
        26 => "000000000000000000",
		27 => "000000000000000000",
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