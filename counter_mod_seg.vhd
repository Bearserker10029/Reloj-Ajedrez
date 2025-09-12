-- Descripción:
--contador descendente de los segundos

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod_seg is
  port(signal clk, g_reset_n: in std_logic;
		signal en_seg,load: in std_logic;
		signal data:in std_logic_vector(5 downto 0);
		signal seg: out std_logic_vector
	    );
end counter_mod_seg;

architecture counter_mod_seg of counter_mod_seg is
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

  comb: process(en_seg, cuenta_actual)
  begin
   if (en_seg = '1') then
	  
	  if (cuenta_actual = 0) then
	    cuenta_siguiente <= "111011";
	  else	
	    cuenta_siguiente <= cuenta_actual - 1;
	  end if; 	
	else
	  cuenta_siguiente <= cuenta_actual;
    end if;
  end process comb;
  
  seg <= std_logic_vector(cuenta_actual);

end counter_mod_seg;