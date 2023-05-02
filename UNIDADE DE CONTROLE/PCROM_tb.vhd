library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCROM_tb is
end;

architecture a_PCROM_tb of PCROM_tb is
    component PCROM
        port(   clk       :in std_logic;
                wr_en     :in std_logic;
                data_in_pc   :in unsigned(3 downto 0);
                data_out_rom  :out unsigned(17 downto 0)
            );
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic :='0';
    signal clk, wr_en: std_logic;
    signal data_in_pc: unsigned (3 downto 0);
    signal data_out_rom: unsigned (17 downto 0);

        begin
            uut: PCROM port map(clk=>clk, wr_en=>wr_en, data_in_pc=> data_in_pc, data_out_rom=>data_out_rom);

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
                wr_en<='1';
                data_in_pc <="0000";
                wait for 100 ns;
                data_in_pc <="0001";
                wait for 100 ns;
                data_in_pc <="0010";
                wait for 100 ns;
                data_in_pc <="0011";
                wait for 100 ns;
                data_in_pc <="0100";
                wait for 100 ns;
                data_in_pc <="0101";
                wait for 100 ns;
                data_in_pc <="0110";
                wait for 100 ns;
                data_in_pc <="0111";
                wait for 100 ns;
                data_in_pc <="1000";
                wait for 100 ns;
                data_in_pc <="1001";
                wait for 100 ns;
                data_in_pc <="1010";
                wait for 100 ns;
                data_in_pc <="1011";
                wait for 100 ns;
                data_in_pc <="1100";
                wait for 100 ns;
                data_in_pc <="1101";
                wait for 100 ns;
                data_in_pc <="1110";
                wait for 100 ns;
                data_in_pc <="1111";
                wait;
        end process;
end architecture;
