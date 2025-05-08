-- Historia de Versión:
-- Versión 1.0 (18/09/2017) - Mario Raffo 
----------------------------------------------------------------------------------------
-- Descripción:
-- Circuito que realiza un conversor la conversión para visualizar en el display, 
-- teniendo una entrada a de 4 bits y una salida f de 7 bits la que representa desde 
-- 0,1,2,3,4,5,6,7,8,9,A,b, C,d,E y F.
-- Se emplea with/select/when
----------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity hexa is
  port(signal a  :  in std_logic_vector(3 downto 0);
	    signal f  : out std_logic_vector(6 downto 0)) ;
end hexa;

architecture structural_0 of hexa is

  constant DONT_CARE : std_logic_vector(6 downto 0):= (others => '-');

begin

  with a select
    f <= "1000000" when x"0",
         "1111001" when x"1",
         "0100100" when x"2",
         "0110000" when x"3",
         "0011001" when x"4",
         "0010010" when x"5",
         "0000010" when x"6",
         "1111000" when x"7",
         "0000000" when x"8",
         "0010000" when x"9",			 
         "0001000" when x"A",
         "0000011" when x"b",
         "1000110" when x"C",
         "0100001" when x"d",
         "0000110" when x"E",
         "0001110" when x"F",			 
         DONT_CARE when others;

end structural_0;