--flip flop d
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FFD is
    port( clk       :in std_logic;
          rst       :in std_logic;
          data_in   :in std_logic;
          wr_en     :in std_logic;
          data_out  :out std_logic
    );
end entity;

architecture a_FFD of FFD is
    
    signal saida: std_logic;
        begin
    process(clk, rst)
    begin
		saida <='0';
        if rst='1' then
            saida <='0';
        elsif wr_en = '1' then
            if rising_edge(clk) then
                saida <= data_in;
            end if;
        end if;
        data_out<=saida;
    end process;
end architecture;
