library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BANCOREG_ULA is
	port(
        mux_sel: in unsigned (0 downto 0);
		banco_r1: in unsigned (2 downto 0);
		banco_r2: in unsigned (2 downto 0);
		write_reg: in unsigned (2 downto 0);
		ULA_load: in std_logic;
		clock: in std_logic;
		reset: in std_logic;
		write_en: in std_logic;
		dado_in: in unsigned (15 downto 0);
		ULA_in: in unsigned (15 downto 0);
		ula_result: out unsigned (15 downto 0);
		ula_sel: in unsigned (1 downto 0);
		mux_s2: in unsigned (15 downto 0);
		reg1, reg2: out unsigned(15 downto 0)
    );
end entity;

architecture a_BANCOREG_ULA of BANCOREG_ULA is
	component BANCOREG is
		port(
			reg1: in unsigned(2 downto 0);
			reg2: in unsigned(2 downto 0);
			dado: in unsigned(15 downto 0);
			wr_reg: in unsigned(2 downto 0);
			wr_en: in std_logic;
			clk: in std_logic;
			rst: in std_logic;
			read_data1: out unsigned(15 downto 0);
			read_data2: out unsigned(15 downto 0)
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
	
	component MUX2x1 is
		port( sinal1: in unsigned(15 downto 0);
			sinal2: in unsigned(15 downto 0);
			sel:	  in unsigned;
			saida: out unsigned(15 downto 0)
			);
	end component;
	
	signal read_d1, read_d2, mux_out, ULA_0: unsigned (15 downto 0);
	
	begin
		ULA0: ULA port map (val0 => ULA_0, val1=> mux_out, sel => ula_sel, saida=> ula_result);
		BANCOREG0: BANCOREG port map (reg1=> banco_r1, reg2=> banco_r2, dado=> dado_in, wr_reg=> write_reg, wr_en=> write_en, clk=> clock, rst=> reset, read_data1=> read_d1, read_data2=> read_d2);
		MUX0: MUX2x1 port map (sinal1=> read_d1, sinal2=> mux_s2, sel=> mux_sel, saida=> mux_out);
		reg1 <= read_d1;
		reg2 <= read_d2;
		
		ULA_0 <= ULA_in when ULA_load = '0' else 
			"0000000000000000";
		
end architecture;