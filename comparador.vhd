-- Descripción:
-- comparar las entradas

library ieee;
use ieee.std_logic_1164.all;

entity comparador is
  generic(N: natural := 6);
  port(A,B: in std_logic_vector(N-1 downto 0);
		EQ: out std_logic
	    );
end comparador;

architecture structural of comparador is

begin

	EQ <= '1' when (A = B) else '0';
	
	
end structural;