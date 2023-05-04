library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOPLVL_contr_tb is
end;

architecture a_TOPLVL_contr_tb of TOPLVL_contr_tb is
    component TOPLVL_contr
        port( clk_pc: in std_logic;
		  rst : in std_logic;
		  clk_contrl: in std_logic;
		  rom_out :out unsigned(17 downto 0)
		);
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, rst: std_logic;
    signal rom_out_sig: unsigned (17 downto 0);

        begin
            uut: TOPLVL_contr port map(clk_contrl=> clk, rst=>rst, clk_pc=> clk, rom_out=>rom_out_sig);

        sim_time_proc: process
        begin  
            wait for 10 us;
            finished<='1';
            wait;
        end process sim_time_proc;
        
        clk_proc: process
        begin
            while finished/='1' loop
                clk <='0';
                wait for period_time/2;
                clk <='1';
                wait for period_time/2;
            end loop;
            wait;
        end process clk_proc;

        process
        begin  
               rst <='0';
                wait;
        end process;
end architecture;
