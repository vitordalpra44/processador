--Unidade de controle
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--teste commit
entity UC is
    port( 	clk : in std_logic;
		  	rst: in std_logic;
			instruction: in unsigned (17 downto 0);
			state: in unsigned(1 downto 0);
		  	fetch : out std_logic;
			execute : out std_logic;
		  	decode : out std_logic;
			wr_en_banco_reg: out std_logic;
			mux_operation: out unsigned(1 downto 0);
			wr_en_acumulador: out std_logic
    );
end entity;

architecture a_UC of UC is
	begin

		fetch <= '1' when state = "00" else
		'0';
		decode <= '1' when state = "01" else
				'0';

		execute <= '1' when state = "10" else
				  '0';
		wr_en_banco <='1' when instruction(17 downto 14) = "0001" else
			'0';
		mux_operation <="00" when instruction(17 downto 14) = "0010" else --opcode de soma
						"01" when instruction(17 downto 14) = "0011" else --opcode subtraçao
						"10" when instruction(17 downto 14) = "0100" else -- opcode multiplicacao
						"11" when instruction(17 downto 14) = "0101" else -- opcode comparacao
						"00";
		wr_en_acumulador <='1' when instruction(17 downto 14) = "0010" else
		

end architecture;
