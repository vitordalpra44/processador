--Unidade de controle
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--teste commit
entity UC is
    port( 	clk 			:in std_logic;
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
end entity;

architecture a_UC of UC is
	signal execute_s: std_logic;
	begin

		fetch <= 	'1' when state = "00" else
					'0';
		decode <= 	'1' when state = "01" else
					'0';
		execute_s <= '1' when state = "10" else
				  	'0';
		execute<=execute_s;




		wr_en_br <=	'1' when instruction(17 downto 14) = "0101" else
					'1' when instruction(17 downto 14) = "1110" else
				   	'0';
		
		mux_operation <="00" when instruction(17 downto 14) = "0001"  or instruction(17 downto 14) = "1001" else --opcode de soma
						"01" when instruction(17 downto 14) = "0010" or instruction(17 downto 14) = "1010" else --opcode subtraçao
						"10" when instruction(17 downto 14) = "0011" else -- opcode multiplicacao
						"11" when instruction(17 downto 14) = "0100" else -- opcode comparacao
						"00";
		
		acumulador_en <= 	'0' when instruction(17 downto 14) = "1000" else 
							'1';
		
		wr_en_acumulador <=	'1' when (instruction(17 downto 14) = "0001" 
									or instruction(17 downto 14) = "1001"
									or instruction(17 downto 14) = "0010"
									or instruction(17 downto 14) = "1010"
									or instruction(17 downto 14) = "0011"
									--or instruction(17 downto 14) = "0100"
									or instruction(17 downto 14) = "1101"
									or instruction(17 downto 14) = "1000") and execute_s='1' else
							'0';
		
		mux_br_ula_sel <=	'1' when instruction(17 downto 14) = "1001" else
							'1' when instruction(17 downto 14) = "1010" else
							'1' when instruction(17 downto 14) = "1000" else
							'0';

		acumulador_en <= 	'0' when instruction(17 downto 14) = "1000" else
							'0' when instruction(17 downto 14) = "1101" else
							'1';
		
		jump_en <=	'1' when instruction(17 downto 14) = "0110" else
					'0';

end architecture;
