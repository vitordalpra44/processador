--Unidade de controle + PC + ROM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_PC_ROM is
    port( 	clk: in std_logic;
			rst : in std_logic;
			wr_en_br: out std_logic;
			PC: out unsigned(3 downto 0);
			state: out unsigned(1 downto 0);
			instr_out :out unsigned(17 downto 0);
			op: out unsigned(1 downto 0); --operacao da ula selecionada
			reg: out unsigned(2 downto 0);
			wr_en_acumulador: out std_logic -- Acumulador
	);
end entity;

architecture a_UC_PC_ROM of UC_PC_ROM is

    component UC is
		port( 	clk : in std_logic;
				rst: in std_logic;
	  			instruction: in unsigned (17 downto 0);
	  			state: in unsigned(1 downto 0);
				fetch_en : out std_logic;
	 			wr_en_reg : out std_logic;
				update_pc : out std_logic;
	  			wr_en_banco_reg: out std_logic;
	  			mux_operation: out unsigned(1 downto 0);
	  			wr_en_acumulador: out std_logic
			);
    end component;
	
	component PCROM is
       port( 	clk_pr  :in std_logic;
				wr_en   :in std_logic;
				rst		:in std_logic;
				data_in_pc   :in unsigned(7 downto 0);
				data_out_rom :out unsigned(17 downto 0);
				data_out_pc  :out unsigned(7 downto 0)
    	);
    end component;
	
	component REG_INSTR is
		port( 	clk       :in std_logic;
          		wr_en     :in std_logic;
          		rst       : in std_logic;
          		data_in   :in unsigned(17 downto 0);
          		data_out  :out unsigned(17 downto 0)
    	);
	end component;
	
	component MAQ_EST is
		port(   clk,rst: in std_logic;
            	estado: out unsigned(1 downto 0)
 			);
	end component;
	
		
	signal instru_reg_instr : unsigned (17 downto 0);
	signal wr_en_br_s : std_logic;
	signal PC_in, PC_out: unsigned (7 downto 0);
	signal enable_PCROM, wr_en_reg_instr, fetch_en : std_logic;
	signal up_pc : std_logic;
	signal estado: unsigned(1 downto 0);
	signal opcode: unsigned(3 downto 0);

	begin
		CONTROLE0 : UC port map (clk=> clk, rst=> rst, instruction=>instru_reg_instr,state=>estado,fetch_en=> fetch_en, wr_en_reg=>wr_en_reg_instr, update_pc=>up_pc, wr_en_br=>wr_en_br_s);
		PCROM0 : PCROM port map (clk_pr=>clk, wr_en=> enable_PCROM, rst=>rst, data_in_pc=> PC_in, data_out_rom=> instru, data_out_pc=>PC_out);
		REG_INSTR1: REG_INSTR port map(clk=>clk, wr_en=>wr_en_reg_instr, rst=>rst, data_in=>instru, data_out=>instru_reg_instr);
		MAQ_EST1: MAQ_EST port map(clk=>clk, rst=>rst, estado=>estado);
		--instru_reg_instr é a instrução que vamos dar execute de fato, instru é a que daremos fetch...
		
-----------------------------------TESTES
		enable_PCROM <= '1'; 
-----------------------------------------
		instr_out <= instru_reg_instr;
		data_out_pc <= PC_out;
		PC_in <= 	instru_reg_instr (6 downto 0) when jump = '1' else
					PC_out + "0001";



end architecture;
