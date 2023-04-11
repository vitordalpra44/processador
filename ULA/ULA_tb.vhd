library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end;

architecture a_ULA_tb of ULA_tb is
    component ULA
        port(
            val0: in unsigned(15 downto 0);
            val1: in unsigned(15 downto 0);
            sel: in unsigned(1 downto 0);
            saida: out unsigned(15 downto 0)
        );
    end component;
    signal val0, val1, saida: unsigned(15 downto 0);
    signal sel: unsigned(1 downto 0);
        begin
            uut: ULA port map(val0=>val0, val1=>val1, saida=>saida, sel=>sel);
        process
        begin

            sel<="00"; --soma
			val1 <="0000000000000001"; -- 1 + 2
            val0 <="0000000000000010";
            wait for 50 ns;
            val1 <="0000000000010111"; -- 23 + 13
            val0 <="0000000000001101";
            wait for 50 ns;
			val1 <="1111111111111111"; -- 65535 + 65535
            val0 <="1111111111111111";
            wait for 50 ns;
			val1 <="0000000000010001"; -- 17 + 5
            val0 <="0000000000000101";
            wait for 50 ns;
			val1 <="0000000001000011"; -- 67 + 30
            val0 <="0000000000011110";
            wait for 50 ns;
			
			
			sel<="01"; -- subtração
			val0 <="0000000000001000"; -- 8 - 5
            val1 <="0000000000000101";
            wait for 50 ns;
			val0 <="0000000000101000"; -- 40 - 24
            val1 <="0000000000011000";
            wait for 50 ns;
			val0 <="0000000000001010"; -- 10 - 45
            val1 <="0000000000101101";
            wait for 50 ns;
			val0 <="0000000000001101"; -- 13 - 16
            val1 <="0000000000010000";
            wait for 50 ns;
			val0 <="0000000000111100"; -- 60 - 20
            val1 <="0000000000010100";
            wait for 50 ns;
			
			
            sel<="10"; -- maior que
			val1 <="0000000000001010"; -- 10 e 12
            val0 <="0000000000001100";
            wait for 50 ns;
			val1 <="0000000000101101"; -- 45 e 35
            val0 <="0000000000100011";
            wait for 50 ns;
			val1 <="0000000000010100"; -- 20 e 21
            val0 <="0000000000010101";
            wait for 50 ns;
			val1 <="0000000000000001"; -- 1 e 2
            val0 <="0000000000000010";
            wait for 50 ns;
			val1 <="0000000000001010"; -- 10 e 5
            val0 <="0000000000000101";
            wait for 50 ns;
			
			sel<="11"; -- Multiplicação
			val0 <="1111111111111111"; -- 65535 * 65535
            val1 <="1111111111111111";
            wait for 50 ns;
			val0 <="0000000000011110"; -- 30 * 2
            val1 <="0000000000000010";
            wait for 50 ns;
			val0 <="0000000000001101"; -- 13 * 3
            val1 <="0000000000000011";
            wait for 50 ns;
			val0 <="0000000000000101"; -- 5 * 4
            val1 <="0000000000000100";
            wait for 50 ns;
			val0 <="0000000000000110"; -- 6 * 6
            val1 <="0000000000000110";
            wait for 50 ns;
            wait;
        end process;
end architecture;
            
