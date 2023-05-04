--Unidade de controle
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity un_controle is
    port( instr : in unsigned(17 downto 0);
		  clk : in std_logic;
		  rst : in std_logic;
		  data_in : in std_logic;
		  jump_en : out std_logic;
		  update_pc : out std_logic
    );
end entity;

architecture a_un_controle of un_controle is

    component FFT is
        port( clk       :in std_logic;
          rst       :in std_logic;
          data_in   :in std_logic;
          data_out  :out std_logic
		);
    end component;
	
	signal opcode : unsigned (3 downto 0);
	signal state : std_logic;

	begin
		FFT0 : FFT port map (clk=> clk, rst=> rst, data_in=> data_in, data_out=> state);
		
		opcode <= instr (17 downto 14) when state = '0' else
				  opcode;
				  
		update_pc <= '1' when state = '1' else
					 '0';
					 
		jump_en <= '1' when opcode = "0011" else
				   '0';

end architecture;
