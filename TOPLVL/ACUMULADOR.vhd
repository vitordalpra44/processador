library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ACUMULADOR is
    port( clk       :in std_logic;
          wr_en     :in std_logic;
          rst       : in std_logic;
          data_in   :in unsigned(15 downto 0);
          data_out  :out unsigned(15 downto 0)
    );
end entity;

architecture a_ACUMULADOR of ACUMULADOR is
    signal registro: unsigned(15 downto 0);
begin
    process(clk, wr_en, rst)
    begin
        if rst = '1' then
            registro <="0000000000000000";
        elsif wr_en='1' then
            if rising_edge(clk) then
                registro<=data_in;
            end if;
        end if;
    end process;
        data_out <=registro;
end architecture;
