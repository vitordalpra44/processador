--ULA + BANCOREG + PC + ROM + UNIDADE DE CONTROLE 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TOPLVL is
    port( clk: in std_logic;
		  rst : in std_logic;
		  estado: in unsigned ;
		  rom_out :out unsigned(17 downto 0)
	);
end entity;