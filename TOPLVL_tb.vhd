library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOPLVL_tb is
end;

architecture a_TOPLVL_tb of TOPLVL_tb is
    component TOPLVL is
        port(
            mux_sel: in unsigned (0 downto 0);
			banco_r1: in unsigned (2 downto 0);
			banco_r2: in unsigned (2 downto 0);
			write_reg: in unsigned (2 downto 0);
			clock: in std_logic;
			reset: in std_logic;
			write_en: in std_logic;
			ula_result: out unsigned (15 downto 0);
			ula_sel: in unsigned (1 downto 0);
			mux_s2: in unsigned (15 downto 0)
        );
    end component;
    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, rst, wr_en: std_logic;
    signal ula_result, mux_s2:unsigned (15 downto 0);
    signal reg1, reg2, wr_reg: unsigned  (2 downto 0);
	signal mux_sel: unsigned (0 downto 0);
	signal ula_sel: unsigned (1 downto 0);

        begin
            uut: TOPLVL port map(mux_sel=> mux_sel, banco_r1=> reg1, banco_r2=> reg2, write_reg=> wr_reg,
			clock=> clk, reset=> rst, write_en=> wr_en, ula_result=> ula_result, ula_sel=> ula_sel, mux_s2=> mux_s2);

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
				mux_sel<="1";
				ula_sel<="00";
                mux_s2<="0000000000111111";

                wait for 100 ns;
                wr_reg<="000";
                wr_en<='1';
                reg1<="001";
                reg2<="000";
				mux_sel<="1";
				ula_sel<="00";
                mux_s2<="0000000011110000";
				
				wait for 100 ns;
                wr_reg<="010";
                wr_en<='1';
                reg1<="001";
                reg2<="000";
				mux_sel<="0";
				ula_sel<="00";
                mux_s2<="0000000011110000";
				
				wait for 100 ns;
                wr_reg<="000";
                wr_en<='0';
                reg1<="011";
                reg2<="010";
				mux_sel<="0";
				ula_sel<="00";
                mux_s2<="0000000011110000";
                wait;
        end process;
end architecture a_TOPLVL_tb;

