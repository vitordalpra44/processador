--Unidade de controle + PC + ROM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_PC_ROM is
    port( clk_pc: in std_logic;
		  rst : in std_logic;
		  clk_contrl: in std_logic;
		  rom_out :out unsigned(17 downto 0);
		  op: out unsigned(1 downto 0);
		  reg1, reg2: out unsigned(2 downto 0);
		  mux_ula_br: out unsigned(0 downto 0)
	);
end entity;

architecture a_UC_PC_ROM of UC_PC_ROM is

    component UC is
       port( instr : in unsigned(17 downto 0);
		  clk : in std_logic;
		  rst : in std_logic;
		  jump_en : out std_logic;
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
	
	
	
	
	signal instru : unsigned (17 downto 0);
	signal jump : std_logic;
	signal PC_in, PC_out: unsigned (3 downto 0);
	signal enable : std_logic;
	signal up_pc : std_logic;


	begin
		CONTROLE0 : UC port map (instr=> instru, clk=> clk_contrl, rst=> rst, jump_en=> jump, update_pc=>up_pc);
		PCROM0 : PCROM port map (clk_pr=>clk_pc, wr_en=> enable, rst=>rst, data_in_pc=> PC_in, data_out_rom=> instru, data_out_pc=>PC_out);
		enable <= '1';
		rom_out <= instru;
		op <= "00";
		PC_in <= 	instru (3 downto 0) when jump = '1' else
					PC_out + "0001";

end architecture;