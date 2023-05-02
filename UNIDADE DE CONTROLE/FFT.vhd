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
    
begin
    process(clk, rst, wr_en)
    begin
        if rst='1' then
            data_out <='0';
        elsif data_in='1' then
            if rising_edge(clk) then
                data_out<= not data_out;
            end if;
        end if;
    end process;
end architecture;
