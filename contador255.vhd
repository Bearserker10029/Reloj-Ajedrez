library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador255 is
  generic(M_INICIAL : natural := 40);
  port(
    clk, reset_n: in std_logic;
    entrada_j: in std_logic;
    umbral_dinamico: in natural;
    mov_out: out std_logic_vector(7 downto 0);
    mov_j_gt_umbral: out std_logic
  );
end Contador255;

architecture cont of Contador255 is
  signal mov: unsigned(7 downto 0);
begin
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      mov <= (others => '0');
    elsif rising_edge(clk) then
      if entrada_j = '1' and mov /= 255 then
        mov <= mov + 1;
      end if;
    end if;
  end process;
  
  mov_j_gt_umbral <= '1' when (mov >= umbral_dinamico) else '0';
  mov_out <= std_logic_vector(mov);
end cont;