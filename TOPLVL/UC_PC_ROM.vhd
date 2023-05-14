--Unidade de controle + PC + ROM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_PC_ROM is
    port( 	clk					:in std_logic;
			rst 				:in std_logic;
			wr_en_br 			:out std_logic;
			wr_en_acumulador	:out std_logic;
			acumulador_en		:out std_logic;
			mux_br_ula_sel		:out std_logic;
			immediate			:out unsigned (15 downto 0);
			PC					:out unsigned(6 downto 0); -- Saida do PC
			state				:out unsigned(1 downto 0);
			instruction_out 	:out unsigned(17 downto 0);
			mux_operation		:out unsigned(1 downto 0); --operacao da ula selecionada
			reg					:out unsigned(2 downto 0) -- mostrar no top lvl para acessar o br			
	);
end entity;

architecture a_UC_PC_ROM of UC_PC_ROM is

    component UC is
		port( 	
				clk 			:in std_logic;
		  		rst				:in std_logic;
				instruction		:in unsigned (17 downto 0);
				state			:in unsigned(1 downto 0);
				jump_en			:out std_logic;
				mux_br_ula_sel	:out std_logic;
				acumulador_en	:out std_logic;
		  		fetch 			:out std_logic;
				execute 		:out std_logic;
		  		decode 			:out std_logic;
				wr_en_br		:out std_logic;
				mux_operation	:out unsigned(1 downto 0);
				wr_en_acumulador:out std_logic
    	);
    end component;
	
	component PCROM is
       port( 	clk  			:in std_logic;
				wr_en   		:in std_logic;
				rst				:in std_logic;
				data_in_pc   	:in unsigned(6 downto 0);
				data_out_rom 	:out unsigned(17 downto 0);
				data_out_pc  	:out unsigned(6 downto 0)
    	);
    end component;
	
	component REG_INSTR is
		port( 	clk       :in std_logic;
          		wr_en     :in std_logic;
          		rst       :in std_logic;
          		data_in   :in unsigned(17 downto 0);
          		data_out  :out unsigned(17 downto 0)
    	);
	end component;
	
	component MAQ_EST is
		port(   clk,rst		:in std_logic;
            	state		:out unsigned(1 downto 0)
 			);
	end component;
	
		
	signal instruction_s, instruction_rom_s : unsigned (17 downto 0);
	signal wr_en_br_s, wr_en_pcrom_s, wr_en_acumulador_s : std_logic;
	signal PC_in, PC_out: unsigned (6 downto 0);
	signal wr_en_reg_instr_s, execute: std_logic;
	signal state_s: unsigned(1 downto 0);
	signal jump_s: std_logic;
	begin
		CONTROLE0 : UC port map (clk=>clk, rst=>rst, instruction=> instruction_s, state =>state_s, jump_en => jump_s, mux_br_ula_sel => mux_br_ula_sel, acumulador_en => acumulador_en, fetch=> wr_en_pcrom_s, execute=>execute , decode=>wr_en_reg_instr_s,wr_en_br=>wr_en_br_s, mux_operation=>mux_operation, wr_en_acumulador=>wr_en_acumulador_s);
		PCROM0 : PCROM port map (clk=>clk, wr_en=> wr_en_pcrom_s, rst=>rst, data_in_pc=> PC_in, data_out_rom=> instruction_rom_s, data_out_pc=>PC_out);
		REG_INSTR1: REG_INSTR port map(clk=>clk, wr_en=>wr_en_reg_instr_s, rst=>rst, data_in=>instruction_rom_s, data_out=>instruction_s);
		MAQ_EST1: MAQ_EST port map(clk=>clk, rst=>rst, state=>state_s);
		wr_en_acumulador <= wr_en_acumulador_s;
		wr_en_br <=wr_en_br_s;
		instruction_out <= instruction_s;
		state <= state_s; 
		PC <= PC_out;

		PC_in <= 	instruction_s (6 downto 0) when jump_s = '1' else
					PC_out + "0000001";

		immediate <= "00" & instruction_s (13 downto 0); 
		
		reg <= instruction_s(2 downto 0);

end architecture;
