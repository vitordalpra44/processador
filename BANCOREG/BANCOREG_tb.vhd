library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BANCOREG_tb is
end;

architecture a_BANCOREG_tb of BANCOREG_tb is
    component BANCOREG
        port(
            reg1: in unsigned(2 downto 0);
            reg2: in unsigned(2 downto 0);
            dado: in unsigned(15 downto 0);
            wr_reg: in unsigned(2 downto 0);
            wr_en: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            read_data1: out unsigned(15 downto 0);
            read_data2: out unsigned(15 downto 0)
        );
    end component;
    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, rst, wr_en: std_logic;
    signal dado, read_data1, read_data2:unsigned (15 downto 0);
    signal reg1, reg2, wr_reg: unsigned  (2 downto 0);

        begin
            uut: BANCOREG port map(clk=>clk, rst=>rst, wr_en=>wr_en, dado=>dado,
             read_data1=>read_data1, read_data2=>read_data2, reg1=>reg1, reg2=>reg2, wr_reg=>wr_reg);

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
                wr_reg<="001";
                wr_en<='1';
                reg1<="000";
                reg2<="001";
                dado<="1111111111111111";

                wait for 100 ns;
                wr_reg<="000";
                wr_en<='1';
                reg1<="000";
                reg2<="001";
                dado<="1001111111100111";
                

                wait for 100 ns;
                wr_reg<="010";
                wr_en<='1';
                reg1<="101";
                reg2<="111";
                dado<="1001111000000111";
                

                wait for 100 ns;
                wr_reg<="111";
                wr_en<='1';
                reg1<="000";
                reg2<="111";
                dado<="1001100011100111";
                

                wait for 100 ns;
                wr_reg<="000";
                wr_en<='1';
                reg1<="000";
                reg2<="001";
                dado<="1001111111100111";
                wait;
        end process;
end architecture a_BANCOREG_tb;

