@echo off

ghdl -a ACUMULADOR.vhd
ghdl -a BANCOREG.vhd
ghdl -a BANCOREG_ULA.vhd
ghdl -a FFT.vhd
ghdl -a FFD.vhd
ghdl -a RAM.vhd
ghdl -a MAQ_EST.vhd
ghdl -a MUX2x1.vhd
ghdl -a MUX4x1.vhd
ghdl -a OPERACOES.vhd
ghdl -a PC.vhd
ghdl -a PCROM.vhd
ghdl -a REGISTRADOR.vhd
ghdl -a REG_INSTR.vhd
ghdl -a ROM.vhd
ghdl -a TOPLVL.vhd
ghdl -a TOPLVL_tb.vhd
ghdl -a UC.vhd
ghdl -a UC_PC_ROM.vhd
ghdl -a ULA.vhd

PAUSE