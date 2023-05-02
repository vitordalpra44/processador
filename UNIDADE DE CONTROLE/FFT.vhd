--flip flop t
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FFT is
    port( clk       :in std_logic;
          rst       :in std_logic;
          data_in   :in std_logic;
          data_out  :out std_logic
    );
end entity;

architecture a_FFT of FFT is
    
    signal saida: std_logic;
        begin
    process(clk, rst)
    begin
        if rst='1' then
            saida <='0';
        elsif data_in='1' then
            if rising_edge(clk) then
                saida <= not saida;
            end if;
        end if;
        data_out<=saida;
    end process;
end architecture;
