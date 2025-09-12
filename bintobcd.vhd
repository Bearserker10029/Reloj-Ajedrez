----------------------------------------------------------------------------------------
-- Archivo: bintobcd.vhd
----------------------------------------------------------------------------------------
-- Autor:     Mg. Ing. Mario Raffo
-- Email:     mraffo@pucp.edu.pe
-- Entidad:   Pontificia Universidad Católica del Perú (PUCP)
-- Facultad:  Estudios Generales Ciencias (EE.GG.CC) 
-- Curso:     1IEE04 - Diseño Digital
----------------------------------------------------------------------------------------
-- Historia de Versión:
-- Versión 1.0 (12/10/2017) - Mario Raffo 
----------------------------------------------------------------------------------------
-- Descripción:
-- Circuito que realiza un conversor de binario a bcd
----------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity bintobcd is
  port(signal a  :  in std_logic_vector(5 downto 0);
	   signal f  : out std_logic_vector(7 downto 0)) ;
end bintobcd;

architecture structural of bintobcd is

  constant DONT_CARE : std_logic_vector(7 downto 0):= (others => '-');
  
  signal a_int : std_logic_vector(7 downto 0);

begin

  a_int <= "00" & a;

  with a_int select
    f <= x"00" when x"00",
         x"01" when x"01",
         x"02" when x"02",
         x"03" when x"03",
         x"04" when x"04",
         x"05" when x"05",
         x"06" when x"06",
         x"07" when x"07",
         x"08" when x"08",
         x"09" when x"09",			 
         x"10" when x"0A",
         x"11" when x"0b",
         x"12" when x"0C",
         x"13" when x"0d",
         x"14" when x"0E",
         x"15" when x"0F",
         x"16" when x"10",
         x"17" when x"11",		 
         x"18" when x"12",
         x"19" when x"13",
         x"20" when x"14",	
         x"21" when x"15",
         x"22" when x"16",		 
         x"23" when x"17",
         x"24" when x"18",
         x"25" when x"19",	
         x"26" when x"1A",
         x"27" when x"1b",		 
         x"28" when x"1C",
         x"29" when x"1d",
         x"30" when x"1E",	
         x"31" when x"1F",	 
         x"32" when x"20",
         x"33" when x"21",
         x"34" when x"22",
         x"35" when x"23",
         x"36" when x"24",
         x"37" when x"25",
         x"38" when x"26",
         x"39" when x"27",
         x"40" when x"28",
         x"41" when x"29",			 
         x"42" when x"2A",
         x"43" when x"2b",
         x"44" when x"2C",
         x"45" when x"2d",
         x"46" when x"2E",
         x"47" when x"2F",
         x"48" when x"30",
         x"49" when x"31",		 
         x"50" when x"32",
         x"51" when x"33",
         x"52" when x"34",	
         x"53" when x"35",
         x"54" when x"36",		 
         x"55" when x"37",
         x"56" when x"38",
         x"57" when x"39",	
         x"58" when x"3A",
         x"59" when x"3b",		 
         x"60" when x"3C",
         x"61" when x"3D",
         x"62" when x"3E",	
         x"63" when x"3F",
         DONT_CARE when others;

end structural;