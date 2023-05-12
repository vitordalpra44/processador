library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BANCOREG_ULA is
	port(
		reg: in unsigned (2 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		wr_en: in std_logic;
		ula_result: out unsigned (15 downto 0);
		ula_sel: in unsigned (1 downto 0); --mux de operacoes
		acumulador: in unsigned (15 downto 0);
		reg_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_BANCOREG_ULA of BANCOREG_ULA is
	component BANCOREG is
		port(
			reg: in unsigned(2 downto 0);
			dado: in unsigned(15 downto 0);
			clk: in std_logic;
			rst: in std_logic;
			read_data: out unsigned(15 downto 0)
		);
	end component;
	
	component ULA is
		port(
            val0: in unsigned(15 downto 0);
            val1: in unsigned(15 downto 0);
            sel: in unsigned(1 downto 0);
            saida: out unsigned(15 downto 0)
		);
	end component;
	
	signal read_d1: unsigned (15 downto 0);
	
	begin
		ULA0: ULA port map (val0 => reg_out, val1=> acumulador, sel => ula_sel, saida=> ula_result);
		BANCOREG0: BANCOREG port map (reg=> reg, dado=> dado_in, wr_en=> wr_en, clk=> clk, rst=> rst, read_data=> read_d1);
		reg_out<= read_d1;

		
end architecture;