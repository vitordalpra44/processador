--Unidade de controle
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--teste commit
entity UC is
    port( 	instr_in: in unsigned(17 downto0);
			instr_out : out unsigned(17 downto 0);
		  	clk : in std_logic;
		  	rst : in std_logic;
		  	jump_en : out std_logic;
		  	update_pc : out std_logic;
			state: in unsigned(1 downto 0);
    );
end entity;

architecture a_UC of UC is
	component REG_INSTR is
		port( clk       :in std_logic;
          wr_en     :in std_logic;
          rst       : in std_logic;
          data_in   :in unsigned(15 downto 0);
          data_out  :out unsigned(15 downto 0)
    );
end component;

	signal opcode : unsigned (3 downto 0);
	signal state : unsigned(1 downto 0);
	signal wr_en_reg: std_logic;

	begin
		REG1 : REG_INSTR port map(clk =>clk, wr_en =>wr_en_reg, rst=>rst, data_in=>instr_in, data_out =>intr_out);

		update_pc <= '1' when state = "00" else
		'0';
		wr_en_reg <= '1' when state = "01" else
				'0';
		opcode <= instr_out (17 downto 14) when state = "10" else
				  opcode;

					 
		jump_en <= '1' when opcode = "0011" else
				   '0';

end architecture;
