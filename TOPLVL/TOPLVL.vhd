--ULA + BANCOREG + PC + ROM + UNIDADE DE CONTROLE + REG_INSTR  + ACUMULADOR
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TOPLVL is
    port( 	clk					:in std_logic;
		  	rst 				:in std_logic;
		  	PC 					:out unsigned(6 downto 0);
		  	instruction			:out unsigned(17 downto 0);
		  	reg					:out unsigned(15 downto 0);
			acumulador_out		:out unsigned(15 downto 0);
		 	ULA					:out unsigned(15 downto 0)
	);
end entity;
architecture a_TOPLVL of TOPLVL is

	component BANCOREG_ULA is
		port(
			reg				:in unsigned (2 downto 0);
			clk				:in std_logic;
			rst				:in std_logic;
			wr_en			:in std_logic;
			mux_sel			:in std_logic;
			acumulador_en	:in std_logic;
			mux_in_2		:in unsigned (15 downto 0);
			carry_subtr     :out std_logic;
            carry_soma      :out std_logic;
			ula_result		:out unsigned (15 downto 0);
			mux_operation	:in unsigned (1 downto 0); --mux de operacoes
			acumulador		:in unsigned (15 downto 0);
			read_data		:out unsigned(15 downto 0)
    );
	end component;

	component UC_PC_ROM is
		port( 	clk					:in std_logic;
				rst 				:in std_logic;
				carry_subtr      	:in std_logic;
            	carry_soma      	:in std_logic;
				wr_en_br 			:out std_logic;
				wr_en_acumulador	:out std_logic;
				acumulador_en		:out std_logic;
				mux_br_ula_sel		:out std_logic;
				wr_en_ffsoma		:out std_logic;
				wr_en_ffsubtr		:out std_logic;
				ram_en				:out std_logic;
				ram_mux				:out std_logic;
				immediate			:out unsigned (15 downto 0);
				PC					:out unsigned(6 downto 0); -- Saida do PC
				state				:out unsigned(1 downto 0);
				instruction_out 	:out unsigned(17 downto 0);
				mux_operation		:out unsigned(1 downto 0); --operacao da ula selecionada
				reg					:out unsigned(2 downto 0) -- mostrar no top lvl para acessar o br			
		);
	end component;
	
	component ACUMULADOR is
		port( 	clk       :in std_logic;
				wr_en     :in std_logic;
				rst       :in std_logic;
				data_in   :in unsigned(15 downto 0);
				data_out  :out unsigned(15 downto 0)
 		 );
	end component;

	component FFD is
		port( clk     	:in std_logic;
          	rst       	:in std_logic;
          	data_in   	:in std_logic;
          	wr_en     	:in std_logic;
          	data_out  	:out std_logic
    	);
	end component;

	component RAM is
		port(
 			clk : in std_logic;
 			endereco : in unsigned(6 downto 0);
 			wr_en : in std_logic;
 			dado_in : in unsigned(15 downto 0);
 			dado_out : out unsigned(15 downto 0)
 		);
	end component;

	component MUX2x1 is
		port( 
			sinal1    :in unsigned(15 downto 0);
          	sinal2    :in unsigned(15 downto 0);
		  	sel       :in std_logic;
          	saida     :out unsigned(15 downto 0)
		);
	end component;

	signal mux_operation_s, state_s: unsigned(1 downto 0);
	signal reg_s: unsigned(2 downto 0);
	signal wr_en_br_s, wr_en_acumulador_s, acumulador_en_s, wr_en_ffsoma_s, wr_en_ffsubtr_s: std_logic;
	signal mux_br_ula_s, carry_subtr_s, carry_soma_s, ff_soma_s, ff_subtr_s, ram_mux_s, ram_en_s: std_logic;
	signal ula_result_s, acumulador_s, immediate_s, br_s, br_in_s, ram_out_s, instruction_s: unsigned (15 downto 0);
	signal instruction_s: unsigned (17 downto 0);
	signal mem_addr_s: unsigned (6 downto 0);

	begin
		BANCOREG_ULA1: BANCOREG_ULA port map(reg=>reg_s, clk=>clk, rst=>rst, wr_en=>wr_en_br_s, mux_sel => mux_br_ula_s,  acumulador_en => acumulador_en_s, mux_in_2 => immediate_s, carry_subtr=> carry_subtr_s, carry_soma=> carry_soma_s, ula_result=>ula_result_s, mux_operation=>mux_operation_s, acumulador=> br_in_s, read_data=>br_s);
		UC_PC_ROM1: UC_PC_ROM port map(clk=>clk, rst=>rst, carry_subtr=> ff_subtr_s, carry_soma=> ff_soma_s, wr_en_br=>wr_en_br_s, wr_en_acumulador=> wr_en_acumulador_s, mux_br_ula_sel => mux_br_ula_s, wr_en_ffsoma=>wr_en_ffsoma_s, wr_en_ffsubtr=>wr_en_ffsubtr_s, ram_en=> ram_en_s, ram_mux=> ram_mux_s, acumulador_en => acumulador_en_s, immediate => immediate_s, PC=> PC, state=>state_s, instruction_out => instruction_s, mux_operation=>mux_operation_s, reg=>reg_s);
		ACUMULADOR1: ACUMULADOR port map(clk=>clk, wr_en=>wr_en_acumulador_s, rst=>rst, data_in=>ula_result_s, data_out=>acumulador_s);
		FF_soma1: FFD port map(clk=>clk, rst=>rst, data_in=>carry_soma_s, wr_en=>wr_en_ffsoma_s, data_out=>ff_soma_s);
		FF_subtr1: FFD port map(clk=>clk, rst=>rst, data_in=>carry_subtr_s, wr_en=>wr_en_ffsubtr_s, data_out=>ff_subtr_s);
		RAM1: RAM port map(clk=> clk, endereco=> mem_addr_s, wr_en=> ram_en_s, dado_in=> br_s, dado_out=> ram_out_s);
		MUX_RAM1: MUX2x1 port map(sinal1=> acumulador_s, sinal2=> ram_out_s, sel=> ram_mux_s, saida=> br_in_s);

		reg <= br_s;
		instruction <= instruction_s;
		mem_addr_s <= acumulador_s (6 downto 0);
		acumulador_out <= acumulador_s;
		ULA <= ula_result_s;
		

	
end architecture;