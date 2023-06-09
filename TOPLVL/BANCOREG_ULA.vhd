library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BANCOREG_ULA is
	port(
		reg				:in unsigned (2 downto 0);
		clk				:in std_logic;
		rst				:in std_logic;
		wr_en			:in std_logic;
		mux_sel			:in std_logic;
		acumulador_en	:in std_logic;
		mux_in_2		:in unsigned (15 downto 0);
		carry_subtr      :out std_logic;
		carry_soma      :out std_logic;
		ula_result		:out unsigned (15 downto 0);
		mux_operation	:in unsigned (1 downto 0); --mux de operacoes
		acumulador		:in unsigned (15 downto 0);
		read_data		:out unsigned(15 downto 0)
    );
end entity;

architecture a_BANCOREG_ULA of BANCOREG_ULA is
	component BANCOREG is
		port(
			reg			:in unsigned(2 downto 0);
			dado		:in unsigned(15 downto 0);
			wr_en 		:in std_logic;
			clk			:in std_logic;
			rst			:in std_logic;
			read_data	:out unsigned(15 downto 0)
		);
	end component;
	
	component ULA is
		port(
            val0			:in unsigned(15 downto 0);
            val1			:in unsigned(15 downto 0);
            mux_operation	:in unsigned(1 downto 0);
			carry_subtr      :out std_logic;
            carry_soma      :out std_logic;
            saida			:out unsigned(15 downto 0)
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
	
	signal read_data_s, mux_data_s, ula_val1_s: unsigned (15 downto 0);
	
	begin
		ULA0: ULA port map (val0 => ula_val1_s, val1=> mux_data_s, mux_operation => mux_operation, carry_subtr=> carry_subtr, carry_soma=> carry_soma, saida=> ula_result);
		BANCOREG0: BANCOREG port map (reg=> reg, dado=> acumulador, wr_en=> wr_en, clk=> clk, rst=> rst, read_data=> read_data_s);
		MUX0: MUX2x1 port map (sinal1 => read_data_s, sinal2 => mux_in_2, sel => mux_sel, saida => mux_data_s);
		
		ula_val1_s <= 	acumulador when acumulador_en = '1' else
						"0000000000000000";
		read_data<= read_data_s;

		
end architecture;