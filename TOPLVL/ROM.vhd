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
        1 =>  "000000000000000000",
        2 =>  "000000000000000000",
        3 =>  "000000000000000000",
        4 =>  "110100000000000100", -- AC <= REG4                       Código assembly:    ADD ,REG4 
        5 =>  "000100000000000011", -- AC <= AC + REG3                  Código assembly:    ADC opr(1),REG3
        6 =>  "010100000000000100", -- REG4 <= AC                       Código assembly:    STA REG4
        7 =>  "110100000000000011", -- AC <= REG3                       Código assembly:    ADD ,REG3
        8 =>  "100100000000000001", -- AC <= AC + 1                     Código assembly:    ADD #1
        9 =>  "010100000000000011", -- REG3 <= AC                       Código assembly:    STA REG3
        10 => "100000000000011110", -- AC <= 30                         Código assembly:    ADD #30
		11 => "110011111110111011", -- Se REG3<AC(=30) jump to instr 4  Código assembly: 
        12 => "110100000000000100", -- AC <= REG4                       Código assembly:    ADD ,REG4 
        13 => "010100000000000101", -- REG5 <= AC                       Código assembly:    STA REG3
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