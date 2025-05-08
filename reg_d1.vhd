-- Descripción:
--Registro Paralelo – Paralelo

library ieee;
use ieee.std_logic_1164.all;

entity reg_d1 is
	port(
	   reset_n: in std_logic;
		clk: in std_logic;
		en_sel: in std_logic;
		modo_sync: in std_logic_Vector(1 downto 0);
		sel:out std_logic_vector(2 downto 0)
		
	);
end reg_d1;

architecture ejemplo of reg_d1 is

begin
	
  process(clk, reset_n,modo_sync )
  begin
		if reset_n='0' then
		sel<="000";
      elsif rising_edge(clk) then 
			if en_sel='1'then 
			sel<='0' & modo_sync;
			end if;
		end if;	
	end process;
	
end ejemplo;