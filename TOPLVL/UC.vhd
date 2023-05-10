--Unidade de controle
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--teste commit
entity UC is
    port( 	instr_in: in unsigned(17 downto 0);
		  	clk : in std_logic;
		  	rst: in std_logic;
			state: in unsigned(1 downto 0);
		  	fetch_en, wr_en_reg : out std_logic;
		  	update_pc : out std_logic
    );
end entity;

architecture a_UC of UC is

	signal opcode : unsigned (3 downto 0);
	signal state : unsigned(1 downto 0);

	begin

		update_pc <= '1' when state = "00" else
		'0';
		wr_en_reg <= '1' when state = "01" else
				'0';

		fetch_en <= '1' when state = "10" else
				  '0';
end architecture;
