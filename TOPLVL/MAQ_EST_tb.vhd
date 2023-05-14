library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAQ_EST_tb is
end;

architecture a_MAQ_EST_tb of MAQ_EST_tb is
    component MAQ_EST
            port(   clk,rst :in std_logic;
                    state  :out unsigned(1 downto 0)
            );
    end component;
    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, rst: std_logic;
    signal state: unsigned(1 downto 0);

    begin
        uut: MAQ_EST port map(clk=>clk, rst=>rst, state=>state);
        
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
 end architecture a_MAQ_EST_tb;   