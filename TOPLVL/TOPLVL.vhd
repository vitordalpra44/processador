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
		port( 	clk: in std_logic;
				rst : in std_logic;
				wr_en_br: in std_logic;
				rom_out, instr_out :out unsigned(17 downto 0);
				op: out unsigned(1 downto 0);
				reg1, reg2, wr_reg: out unsigned(2 downto 0);
				mux_ula_br: out unsigned(0 downto 0);
				A_wr_en: out std_logic -- Acumulador
		)
	end component;
	
	component ACUMULADOR is
		port( 	clk       :in std_logic;
				wr_en     :in std_logic;
				rst       : in std_logic;
				data_in   :in unsigned(15 downto 0);
				data_out  :out unsigned(15 downto 0);

 		 );
end component;
	signal operacao: unsigned(1 downto 0);
	signal reg1, reg2, wr_rg: unsigned(2 downto 0);
	signal ula_br: unsigned(0 downto 0);
	signal wr_en_br: std_logic;
	signal mux_s2, data_in_A, data_out_A: unsigned (15 downto 0);
	signal rom_out: unsigned (17 downto 0);
	
	begin
		BANCOREG_ULA1: BANCOREG_ULA port map(mux_sel=>ula_br, banco_r1=>reg1, banco_r2=>reg2, write_reg=>wr_rg, clock=>clk, reset=>rst, write_en=>wr_en_br, ula_result=>ULA, ula_sel=>operacao, mux_s2=>mux_s2);
		UC_PC_ROM1: UC_PC_ROM port map(clk=>clk, rst=>rst, wr_en_br=>wr_en_br, rom_out=>rom_out, instr_out=>instrucao, op=>operacao, reg1=>reg1, reg2=>reg2, wr_reg=>wr_rg,mux_ula_br=>ula_br);
		ACUMULADOR1: ACUMULADOR port map(clk=>clk, wr_en=>A_wr_en, rst=>rst, data_in=>data_in_A, data_out=>data_out_A);


end architecture;