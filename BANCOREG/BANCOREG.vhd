library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BANCOREG is
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

    signal r_data0, r_data1, r_data2, r_data3, r_data4, r_data5, r_data6, r_data7: out unsigned(15 downto 0);
            wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: in std_logic;
        begin
        REGISTRADOR0: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en0, data_in=>dado, data_out=>r_data0);
        REGISTRADOR1: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en1, data_in=>dado, data_out=>r_data1);
        REGISTRADOR2: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en2, data_in=>dado, data_out=>r_data2);
        REGISTRADOR3: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en3, data_in=>dado, data_out=>r_data3);
        REGISTRADOR4: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en4, data_in=>dado, data_out=>r_data4);
        REGISTRADOR5: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en5, data_in=>dado, data_out=>r_data5);
        REGISTRADOR6: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en6, data_in=>dado, data_out=>r_data6);
        REGISTRADOR7: REGISTRADOR port map(clk=> clk, rst=>rst, wr_en=>wr_en7, data_in=>dado, data_out=>r_data7);
        
        read_data1 <= r_data0 when reg1 = "000" else
                      r_data1 when reg1 ="001" else
                      r_data2 when reg1 = "010" else
                      r_data3 when reg1 = "011" else
                      r_data4 when reg1 ="100" else
                      r_data5 when reg1 = "101" else
                      r_data6 when reg1 = "110" else
                      r_data7 when reg1 ="111" else
                      "0000000000000000";

        read_data2 <= r_data0 when reg2 = "000" else
                      r_data1 when reg2 ="001" else
                      r_data2 when reg2 = "010" else
                      r_data3 when reg2 = "011" else
                      r_data4 when reg2 ="100" else
                      r_data5 when reg2 = "101" else
                      r_data6 when reg2 = "110" else
                      r_data7 when reg2 ="111" else
                      "0000000000000000";
        
        wr_en0 <= wr_en when wr_reg ="000" else "0";
        wr_en1 <= wr_en when wr_reg ="001" else "0";
        wr_en2 <= wr_en when wr_reg ="010" else "0";
        wr_en3 <= wr_en when wr_reg ="011" else "0";
        wr_en4 <= wr_en when wr_reg ="100" else "0";
        wr_en5 <= wr_en when wr_reg ="101" else "0";
        wr_en6 <= wr_en when wr_reg ="110" else "0";
        wr_en7 <= wr_en when wr_reg ="111" else "0";

    end architecture;