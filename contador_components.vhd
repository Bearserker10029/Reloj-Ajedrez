-- Descripción:
-- Componentes del contador de movimiento

library ieee;
use ieee.std_logic_1164.all;

package contador_components is
	component Contador255 is
		 port(	signal clk, reset_n: in std_logic;
			signal entrada_j: in std_logic;
			signal mov_out: out std_logic_vector(7 downto 0);
			signal mov_j_gt40: out std_logic	);
	end component;
	
	component bintobcd1 is
	  port(signal a  :  in std_logic_vector(7 downto 0);
			signal f  : out std_logic_vector(11 downto 0)) ;
	end component;
	
	component hexa is
  port(signal a  :  in std_logic_vector(3 downto 0);
	    signal f  : out std_logic_vector(6 downto 0)) ;
	end component;
end package;