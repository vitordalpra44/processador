library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGISTRADOR_tb is
end;

architecture a_REGISTRADOR_tb of REGISTRADOR_tb is
    component REGISTRADOR
        port(
          clk       :in std_logic;
          rst       :in std_logic;
          wr_en     :in std_logic;
          data_in   :in unsigned(15 downto 0);
          data_out  :out unsigned(15 downto 0)
        );
    end component;
    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, rst, wr_en: std_logic;
    signal data_in, data_out:unsigned (15 downto 0);

        begin
            uut: REGISTRADOR port map(clk=>clk, rst=>rst, wr_en=>wr_en, data_in=>data_in, data_out=>data_out);

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
                wait for 200 ns;
                wr_en<='0';
                data_in<="1111111111111111";
                wait for 100 ns;
                data_in<="1001111111100111";
                wait;
        end process;
end architecture a_REGISTRADOR_tb;


