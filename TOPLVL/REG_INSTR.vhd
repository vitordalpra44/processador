library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REG_INSTR is
    port( clk       :in std_logic;
          wr_en     :in std_logic;
          rst       : in std_logic;
          data_in   :in unsigned(17 downto 0);
          data_out  :out unsigned(17 downto 0)
    );
end entity;

architecture a_REG_INSTR of REG_INSTR is
    signal registro: unsigned(17 downto 0);
begin
    process(clk, wr_en, rst)
    begin
        if rst = '1' then
            registro <="000000000000000000";
        elsif wr_en='1' then
            if rising_edge(clk) then
                registro<=data_in;
            end if;
        end if;
    end process;
        data_out <=registro;
end architecture;
