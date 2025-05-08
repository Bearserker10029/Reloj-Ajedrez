library ieee;
use ieee.std_logic_1164.all;

entity sincronizador is
  port(
    reset_n: in std_logic;
    config: in std_logic;
    clk: in std_logic;
    ini_pausa: in std_logic;
    jugador_act: in std_logic;
    bonus: in std_logic;
    modo: in std_logic_vector(1 downto 0);
    ver_disp: in std_logic_vector(1 downto 0);
    config_sync: out std_logic;
    ini_pausa_sync: out std_logic;
    jugador_act_sync: out std_logic;
    bonus_sync: out std_logic;
    modo_sync: out std_logic_vector(1 downto 0);
    ver_disp_sync: out std_logic_vector(1 downto 0)
  );
end sincronizador;

architecture structural of sincronizador is
begin
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      config_sync <= '0';
      ini_pausa_sync <= '0';
      jugador_act_sync <= '0';
      bonus_sync <= '0';
      modo_sync <= "00";
      ver_disp_sync <= "00";
    elsif rising_edge(clk) then
      config_sync <= config;
      ini_pausa_sync <= ini_pausa;
      jugador_act_sync <= jugador_act;
      bonus_sync <= bonus;
      modo_sync <= modo;
      ver_disp_sync <= ver_disp;
    end if;
  end process;
end structural;