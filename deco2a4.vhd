-- Descripción:
--decodificar de 2 bits a 4 bits

library ieee;
use ieee.std_logic_1164.all;

entity deco2a4 is
	port(
	   en: in std_logic;
		w: in std_logic_vector(1 downto 0);
		y: out std_logic_Vector(3 downto 0)
	);
end deco2a4;

architecture ejemplo of deco2a4 is

begin
 process(w,en)
 begin
 if en='0' then
 y<="0000";
 elsif en='1' then
	if w="00" then
	 y<="0001";
	 elsif w="01" then
	 y<="0010";
	 elsif w="10" then
	 y<="0100";
	 elsif w="11" then
	 y<="1000";
	 else
	 y<="----";
	 end if;
	end if;
 end process;

end ejemplo;