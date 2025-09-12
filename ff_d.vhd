-- Descripción:
--flip flop tipo D

library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
	port(
	   reset_n: in std_logic;
		clk, d: in std_logic;
		q: out std_logic
	);
end ff_d;

architecture ejemplo of ff_d is

begin
	
  process(clk, reset_n, d)
  begin
		if reset_n='0' then
		q<='0';
      elsif rising_edge(clk) then 
      q<=d;
		end if;	
	end process;
	
end ejemplo;