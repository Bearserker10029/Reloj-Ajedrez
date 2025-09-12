-- Descripción:
--contador descendente de las horas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod_hour is
  port(signal clk, g_reset_n: in std_logic;
		signal en_hour,load: in std_logic;
		signal data:in std_logic_vector(1 downto 0);
		signal hour: out std_logic_vector(1 downto 0)
	    );
end counter_mod_hour;

architecture counter_mod_hour of counter_mod_hour is
signal cuenta_actual, cuenta_siguiente,data_in: unsigned(1 downto 0);


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

  comb: process(en_hour, cuenta_actual)
  begin
   if (en_hour = '1') then
	  
	  if (cuenta_actual = 0) then
	    cuenta_siguiente <= "00";
	  else	
	    cuenta_siguiente <= cuenta_actual - 1;
	  end if; 	
	else
	  cuenta_siguiente <= cuenta_actual;
    end if;
  end process comb;
  
  hour <= std_logic_vector(cuenta_actual); 

end counter_mod_hour;