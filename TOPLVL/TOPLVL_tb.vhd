library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOPLVL_tb is
end;

architecture a_TOPLVL_tb of TOPLVL_tb is
    component TOPLVL
        port(   clk					:in std_logic;
                rst 				:in std_logic;
                PC 					:out unsigned(6 downto 0);
                instruction			:out unsigned(17 downto 0);
                reg					:out unsigned(15 downto 0);
                acumulador_out		:out unsigned(15 downto 0);
                ULA					:out unsigned(15 downto 0)
         );
    end component;
    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, rst: std_logic;
    signal reg, ULA, acumulador: unsigned  (15 downto 0);
    signal instru: unsigned (17 downto 0);
    signal PC_out: unsigned (6 downto 0);

    begin
        uut: TOPLVL port map(clk=>clk, rst=>rst, PC=>PC_out, instruction=>instru, reg=>reg, acumulador_out=>acumulador, ULA=>ULA);
        
        reset_global: process
        begin
            rst<='1';
            wait for period_time*2;
            rst<='0';
            wait;
        end process;

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
                rst <= '1';
                wait for 100 ns;
                rst <= '0';
                wait;
        end process;    
 end architecture a_TOPLVL_tb;   