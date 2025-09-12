-- Descripción:
-- seleccionar la salida display a partir de las entradas

library ieee;
use ieee.std_logic_1164.all;

entity mux4a1 is
	port(
		a, b, c, d: in std_logic_vector(6 downto 0);
		sel: in std_logic_vector(1 downto 0);
		f: out std_logic_vector(6 downto 0)
	);
end mux4a1;

architecture mux of mux4a1 is

begin
	
		f <= a when sel="00" else
			  b when sel="01" else
			  c when sel="10" else
			  d;
	
end mux;