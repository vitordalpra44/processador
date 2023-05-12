--ULA + BANCOREG + PC + ROM + UNIDADE DE CONTROLE + REG_INSTR 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TOPLVL is
    port( clk: in std_logic;
		  rst : in std_logic;
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
		reg: in unsigned (2 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		wr_en: in std_logic;
		ula_result: out unsigned (15 downto 0);
		ula_sel: in unsigned (1 downto 0);
		acumulador: in unsigned (15 downto 0);
		reg_out: out unsigned(15 downto 0)
		);
	end component;

	component UC_PC_ROM is
		port( 	clk: in std_logic;
			rst : in std_logic;
			wr_en_br: out std_logic;
			ULA_load: out std_logic;
			immediate: out unsigned (15 downto 0);
			data_out_pc: out unsigned(3 downto 0);
			rst_A: out std_logic;
			rom_out, instr_out :out unsigned(17 downto 0);
			op: out unsigned(1 downto 0); --operacao da ula selecionada
			reg1, reg2, wr_reg: out unsigned(2 downto 0);
			mux_ac_br: out unsigned(0 downto 0); --mux que seleciona ou ula ou banco reg para 2° entrada operacao
			A_wr_en: out std_logic -- Acumulador
	);
	end component;
	
	component ACUMULADOR is
		port( 	clk       :in std_logic;
				wr_en     :in std_logic;
				rst       : in std_logic;
				data_in   :in unsigned(15 downto 0);
				data_out  :out unsigned(15 downto 0)

 		 );
end component;
	signal operacao: unsigned(1 downto 0);
	signal  wr_rg, reg1t, reg2t: unsigned(2 downto 0);
	signal ula_br: unsigned(0 downto 0);
	signal wr_en_br_s, A_wr_en, rst_A, ula_l: std_logic;
	signal immediate, mux_s2, data_in_A, data_out_A, reg1s, reg2s, ULA_res: unsigned (15 downto 0);
	signal rom_out, instr: unsigned (17 downto 0);
	
	begin
		BANCOREG_ULA1: BANCOREG_ULA port map(reg=>reg1t, clk=>clk, rst=>rst, wr_en=>wr_en_br_s, ula_result=>ULA_res, ula_sel=>operacao, acumulador=> immediate, reg_out=>reg1);
		UC_PC_ROM1: UC_PC_ROM port map(clk=>clk, rst=>rst, wr_en_br=>wr_en_br_s, ULA_load=> ula_l, immediate=> immediate, data_out_pc=>PC, rst_A=>rst_A, rom_out=>rom_out, instr_out=>instr, op=>operacao, reg1=>reg1t, reg2=>reg2t, wr_reg=>wr_rg,mux_ac_br=>ula_br, A_wr_en => A_wr_en);
		ACUMULADOR1: ACUMULADOR port map(clk=>clk, wr_en=>A_wr_en, rst=>rst_A, data_in=>ULA_res, data_out=>data_out_A);
		instrucao <=instr;

		reg1<=reg1s;

	
end architecture;