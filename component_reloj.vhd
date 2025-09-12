-- Descripción:
--componentes para reloj.vhd

library ieee;
use ieee.std_logic_1164.all;

package component_reloj is
	component divisor_freq is
	  generic (N         : natural := 50000000;        
				  BUS_WIDTH : natural := 26);
	  port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal clk_o   : out std_logic);
	end component;
	
	component bintobcd is
		port(signal a  :  in std_logic_vector(5 downto 0);
	   signal f  : out std_logic_vector(7 downto 0)) ;
	end component;
	
	component hexa is
  port(signal a  :  in std_logic_vector(3 downto 0);
	    signal f  : out std_logic_vector(6 downto 0)) ;
	end component;
	
	component counter_mod_seg is
  port(signal clk, g_reset_n: in std_logic;
		signal en_seg,load: in std_logic;
		signal data:in std_logic_vector(5 downto 0);
		signal seg: out std_logic_vector);
	end component;
	
	component counter_mod_min is
  port(signal clk, g_reset_n: in std_logic;
		signal en_min,load: in std_logic;
		signal data:in std_logic_vector(5 downto 0);
		signal min: out std_logic_vector);
	end component;
	
	component comparador is
  generic(N: natural := 6);
  port(A,B: in std_logic_vector(N-1 downto 0);
		EQ: out std_logic
	    );
	end component;
	
	component counter_mod_hour is
  port(signal clk, g_reset_n: in std_logic;
		signal en_hour,load: in std_logic;
		signal data:in std_logic_vector(1 downto 0);
		signal hour: out std_logic_vector
	    );
	end component;

	
end package;
