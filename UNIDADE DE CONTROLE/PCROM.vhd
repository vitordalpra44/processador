--Conectando o PC à ROM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCROM is
    port( clk_pr     :in std_logic;
          wr_en     :in std_logic;
          data_in_pc   :in unsigned(3 downto 0);
          data_out_rom  :out unsigned(17 downto 0)
    );
end entity;

architecture a_PCROM of PCROM is


    component PC is
        port(   clk       :in std_logic;
                wr_en     :in std_logic;
                data_in   :in unsigned(3 downto 0);
                data_out  :out unsigned(3 downto 0)
        );
    end component;


    component ROM is
        port(   clk: in std_logic;
                endereco : in unsigned(3 downto 0);
                dado: out unsigned(17 downto 0)
            );
    end component;


    signal registro: unsigned(3 downto 0);
        begin
        PC0: PC port map(clk=>clk_pr, wr_en=>wr_en, data_in =>data_in_pc, data_out=>registro);
        ROM0: ROM port map(clk=>clk_pr, endereco=>registro, dado=>data_out_rom);

end architecture;
