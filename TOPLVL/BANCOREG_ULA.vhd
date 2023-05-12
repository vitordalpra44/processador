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
		mux_operation: in unsigned (1 downto 0); --mux de operacoes
		acumulador: in unsigned (15 downto 0);
		read_data: out unsigned(15 downto 0)
    );
end entity;

architecture a_BANCOREG_ULA of BANCOREG_ULA is
	component BANCOREG is
		port(
			reg: in unsigned(2 downto 0);
			dado: in unsigned(15 downto 0);
			wr_en :in std_logic;
			clk: in std_logic;
			rst: in std_logic;
			read_data: out unsigned(15 downto 0)
		);
	end component;
	
	component ULA is
		port(
            val0: in unsigned(15 downto 0);
            val1: in unsigned(15 downto 0);
            mux_operation: in unsigned(1 downto 0);
            saida: out unsigned(15 downto 0)
		);
	end component;
	
	signal read_data_s: unsigned (15 downto 0);
	
	begin
		ULA0: ULA port map (val0 => read_data_s, val1=> acumulador, mux_operation => mux_operation, saida=> ula_result);
		BANCOREG0: BANCOREG port map (reg=> reg, dado=> acumulador, wr_en=> wr_en, clk=> clk, rst=> rst, read_data=> read_data_s);
		read_data<= read_data_s;

		
end architecture;