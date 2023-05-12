library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BANCOREG is
    port(
        reg: in unsigned(2 downto 0);
        dado: in unsigned(15 downto 0);
        wr_en: in std_logic;
        clk: in std_logic;
        rst: in std_logic;
        read_data: out unsigned(15 downto 0)

    );
end entity;
architecture a_BANCOREG of BANCOREG is
    component REGISTRADOR is
        port(
            clk       :in std_logic;
            rst       :in std_logic;
            wr_en     :in std_logic;
            data_in   :in unsigned(15 downto 0);
            data_out  :out unsigned(15 downto 0)
      );
    end component;

    signal r_data0, r_data1, r_data2, r_data3, r_data4, r_data5, r_data6, r_data7: unsigned(15 downto 0);
    signal wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: std_logic;
        begin
        REGISTRADOR0: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en0, data_in=>dado, data_out=>r_data0);
        REGISTRADOR1: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en1, data_in=>dado, data_out=>r_data1);
        REGISTRADOR2: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en2, data_in=>dado, data_out=>r_data2);
        REGISTRADOR3: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en3, data_in=>dado, data_out=>r_data3);
        REGISTRADOR4: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en4, data_in=>dado, data_out=>r_data4);
        REGISTRADOR5: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en5, data_in=>dado, data_out=>r_data5);
        REGISTRADOR6: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en6, data_in=>dado, data_out=>r_data6);
        REGISTRADOR7: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en7, data_in=>dado, data_out=>r_data7);
        
        read_data <= r_data0 when reg = "000" else
                      r_data1 when reg ="001" else
                      r_data2 when reg = "010" else
                      r_data3 when reg = "011" else
                      r_data4 when reg ="100" else
                      r_data5 when reg = "101" else
                      r_data6 when reg = "110" else
                      r_data7 when reg ="111" else
                      "0000000000000000";
   
        wr_en0 <= wr_en when reg ="000" else '0';
        wr_en1 <= wr_en when reg ="001" else '0';
        wr_en2 <= wr_en when reg ="010" else '0';
        wr_en3 <= wr_en when reg ="011" else '0';
        wr_en4 <= wr_en when reg ="100" else '0';
        wr_en5 <= wr_en when reg ="101" else '0';
        wr_en6 <= wr_en when reg ="110" else '0';
        wr_en7 <= wr_en when reg ="111" else '0';

    end architecture;