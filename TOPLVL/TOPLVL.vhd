--ULA + BANCOREG + PC + ROM + UNIDADE DE CONTROLE + REG_INSTR 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TOPLVL is
    port( clk: in std_logic;
		  rst : in std_logic;
		  state: in unsigned(1 downto 0);
		  PC :out unsigned(3 downto 0);
		  instrucao: out unsigned(17 downto 0);
		  reg1: out unsigned(15 downto 0);
		  reg2: out unsigned(15 downto 0);
		  ULA: out unsigned(15 downto 0)
	);
end entity;
architecture a_TOPLVL of TOPLVL is

	component BANCOREG_ULA is
		port(
			mux_sel: in unsigned (0 downto 0);
			banco_r1: in unsigned (2 downto 0);
			banco_r2: in unsigned (2 downto 0);
			write_reg: in unsigned (2 downto 0);
			clock: in std_logic;
			reset: in std_logic;
			write_en: in std_logic;
			ula_result: out unsigned (15 downto 0);
			ula_sel: in unsigned (1 downto 0);
			mux_s2: in unsigned (15 downto 0)
		);
	end component;

	component UC_PC_ROM is
		port( 	clk_pc: in std_logic;
				rst : in std_logic;
				clk_contrl: in std_logic;
				rom_out :out unsigned(17 downto 0)
		);
	end component;


	begin
		BANCOREG_ULA1: BANCOREG_ULA port map(mux_sel)--PAREI AQUI...

end architecture;