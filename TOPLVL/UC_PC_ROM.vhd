--Unidade de controle + PC + ROM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_PC_ROM is
    port( 	clk: in std_logic;
			rst : in std_logic;
			wr_en_br: in std_logic;
			rom_out, instr_out :out unsigned(17 downto 0);
			op: out unsigned(1 downto 0); --operacao da ula selecionada
			reg1, reg2, wr_reg: out unsigned(2 downto 0);
			mux_ula_br: out unsigned(0 downto 0); --mux que seleciona ou ula ou banco reg para 2° entrada operacao
			A_wr_en: out std_logic -- Acumulador
	);
end entity;

architecture a_UC_PC_ROM of UC_PC_ROM is

    component UC is
		port( 	instr_in: in unsigned(17 downto 0);
				clk : in std_logic;
				rst: in std_logic;
				state: in unsigned(1 downto 0);
				fetch_en, wr_en_reg : out std_logic;
				update_pc : out std_logic
			);
    end component;
	
	component PCROM is
       port( clk_pr       :in std_logic;
          wr_en     :in std_logic;
		  rst		:in std_logic;
          data_in_pc   :in unsigned(3 downto 0);
          data_out_rom  :out unsigned(17 downto 0);
		  data_out_pc : out unsigned(3 downto 0)
    	);
    end component;
	
	component REG_INSTR is
		port( clk       :in std_logic;
          wr_en     :in std_logic;
          rst       : in std_logic;
          data_in   :in unsigned(15 downto 0);
          data_out  :out unsigned(15 downto 0)
    	);
	end component;
	component MAQ_EST is
		port(   clk,rst: in std_logic;
            	estado: out unsigned(1 downto 0)
 			);
	end component;
	
		
	signal instru, instru_reg_instr : unsigned (17 downto 0);
	signal jump : std_logic;
	signal PC_in, PC_out: unsigned (3 downto 0);
	signal enable_PCROM, wr_en_reg_instr, fetch_en : std_logic;
	signal up_pc : std_logic;
	signal estado: unsigned(1 downto 0);

	begin
		CONTROLE0 : UC port map (instr_in=> instru, clk=> clk, rst=> rst, state=>estado,fetch_en=> fetch_en, wr_en_reg=>wr_en_reg_instr, update_pc=>up_pc);
		PCROM0 : PCROM port map (clk_pr=>clk, wr_en=> enable, rst=>rst, data_in_pc=> PC_in, data_out_rom=> instru, data_out_pc=>PC_out);
		REG_INSTR1: REG_INSTR port map(clk=>clk, wr_en=>wr_en_reg_instr, rst=>rst, data_in=>instru, data_out=>instru_reg_instr);
		MAQ_EST1: MAQ_EST port map(clk=>clk, rst=>rst, estado=>estado);
		--instru_reg_instr é a instrução que vamos dar execute de fato, instru é a que daremos fetch...
		
-----------------------------------TESTES
		enable_PCROM <= '1'; 
		op <= "00";
-----------------------------------------
		intr_out <= instru_reg_instr;
		rom_out <= instru;
		PC_in <= 	instru_reg_instr (3 downto 0) when jump = '1' else
					PC_out + "0001";

		--DESCREVER A ACÃO DE CADA OPCODE...

	--JUMP : FORMATO "0011"_"XXXXXXXXXX"_"MMMM" em que MMMM é o endereço de memória para onde irá saltar
		jump <= '1' when instru_reg_instr(17 downto 14) = "0011" else
			0;

		op <= "00" when instru_reg_instr()

end architecture;
