-- Descripción:
--contador descendente de los minutos

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod_min is
  port(signal clk, g_reset_n: in std_logic;
		signal en_min,load: in std_logic;
		signal data:in std_logic_vector(5 downto 0);
		signal min: out std_logic_vector
	    );
end counter_mod_min;

architecture counter_mod_min of counter_mod_min is
signal cuenta_actual, cuenta_siguiente,data_in: unsigned(5 downto 0);

begin
	 data_in<=unsigned(data);
	 seq: process(g_reset_n,clk)
	  begin
		 if (g_reset_n = '0') then
			cuenta_actual <= (others => '0');
			 elsif rising_edge(clk) then
			cuenta_actual <= cuenta_siguiente; 
		if (load='1')then cuenta_actual<=data_in;	
		 end if;
		 end if;
	  end process seq;

  comb: process(en_min, cuenta_actual)
  begin
   if (en_min = '1') then
	  
	  if (cuenta_actual = 0) then
	    cuenta_siguiente <= "111011";
	  else	
	    cuenta_siguiente <= cuenta_actual - 1;
	  end if; 	
	else
	  cuenta_siguiente <= cuenta_actual;
    end if;
  end process comb;
  
  min <= std_logic_vector(cuenta_actual); 
end counter_mod_min;