----------------------------------------------------------------------------------------
-- Archivo: divisor_freq.vhd
----------------------------------------------------------------------------------------
-- Autor:     Mg. Ing. Mario Raffo
-- Email:     mraffo@pucp.edu.pe
-- Entidad:   Pontificia Universidad Católica del Perú (PUCP)
-- Facultad:  Estudios Generales Ciencias (EE.GG.CC) 
-- Curso:     1IEE04 - Diseño Digital
----------------------------------------------------------------------------------------
-- Historia de Versión:
-- Versión 1.0 (27/10/2020) - Mario Raffo 
----------------------------------------------------------------------------------------
-- Descripción:
-- Circuito basado en un contador mod N
----------------------------------------------------------------------------------------

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_freq is
  generic (N         : natural := 50000000;        
           BUS_WIDTH : natural := 26);
  port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal clk_o   : out std_logic);
end divisor_freq;

architecture structural of divisor_freq is

  signal clk_o_reg  : std_logic;
  signal clk_o_next : std_logic;
  signal q_reg      : unsigned(BUS_WIDTH-1 downto 0);
  signal q_next     : unsigned(BUS_WIDTH-1 downto 0);
  
begin

  seq: process(reset_n,clk)
  begin
    if (reset_n = '0') then
	  clk_o_reg <= '0';
      q_reg <= (others => '0');
    elsif rising_edge(clk) then
	  clk_o_reg <= clk_o_next;
      q_reg <= q_next;  
    end if;
  end process seq;

  comb: process(q_reg)
  begin
	if (q_reg = (N-1)) then
	  clk_o_next <= '1'; 
	  q_next <= (others => '0');
	else
      clk_o_next <= '0'; 	  
	  q_next <= q_reg + 1;
	end if; 	
  end process comb;
  
  clk_o <= clk_o_reg; 
  
end structural;