library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port(
            val0            :in unsigned(15 downto 0);
            val1            :in unsigned(15 downto 0);
            mux_operation   :in unsigned(1 downto 0);
            carry_subtr      :out std_logic;
            carry_soma      :out std_logic;
            saida           :out unsigned(15 downto 0)

    );
end entity;

architecture a_ULA of ULA is
    component MUX4x1 is
        port(   ope1              :in unsigned(15 downto 0);
                ope2              :in unsigned(15 downto 0);
                ope3              :in unsigned(15 downto 0);
                ope4              :in unsigned(15 downto 0); 
                sel               :in unsigned(1 downto 0);
                saida             :out unsigned(15 downto 0));
    end component;
    component OPERACOES is
        port(   val0            :in unsigned(15 downto 0);
                val1            :in unsigned(15 downto 0);
                carry_subtr      :out std_logic;
                carry_soma      :out std_logic;
                soma            :out unsigned(15 downto 0);
                subtracao       :out unsigned(15 downto 0); 
                maior_que       :out unsigned(15 downto 0);
                multiplicacao   :out unsigned(15 downto 0));
    end component;
    signal ope1, ope2, ope3, ope4: unsigned(15 downto 0);
        begin 
            mux4x11: MUX4x1 port map (saida=>saida, ope1=>ope1, ope2=>ope2, ope3=>ope3,ope4=>ope4, sel=>mux_operation);
            operacoes1: OPERACOES port map (val0=>val0, val1=>val1, carry_subtr=> carry_subtr, carry_soma=> carry_soma,  soma=>ope1, subtracao=>ope2, maior_que=>ope3, multiplicacao=>ope4);
end architecture;