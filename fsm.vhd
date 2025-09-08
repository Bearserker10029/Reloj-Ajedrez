library ieee;
use ieee.std_logic_1164.all;

entity fsm is
  port(
    clk, reset_n, en, config_sync, ini_pausa_sync, jugador_act_sync,
    min_value_j0, min_value_j1, mov_j0_gt40, mov_j1_gt40,
    mov_j0_gt_16, mov_j1_gt_16, min_value_1hora_j0, min_value_1hora_j1, bonus_sync: in std_logic;
    modo_sync: in std_logic_vector(1 downto 0);
    ini_pausa_j0, borrar_j0, ini_pausa_j1, borrar_j1, en_sel, en_j0, en_j1, load2, loadbonus, pierde_j0, pierde_j1: out std_logic
  );
end fsm;

architecture structural of fsm is
  type estado_type is (IDLE, CONFIG, PLAY, PAUSE, GAME_OVER);
  signal estado_actual, estado_siguiente: estado_type;
  signal fase_actual_j0, fase_actual_j1: std_logic := '0';
begin
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      estado_actual <= IDLE;
      fase_actual_j0 <= '0';
      fase_actual_j1 <= '0';
    elsif rising_edge(clk) then
      estado_actual <= estado_siguiente;
    
      -- Actualización de fases solo en flanco de reloj
      if estado_actual = PLAY and modo_sync = "10" then
        if mov_j0_gt40 = '1' and fase_actual_j0 = '0' then
          fase_actual_j0 <= '1';
        end if;
        
        if mov_j1_gt40 = '1' and fase_actual_j1 = '0' then
          fase_actual_j1 <= '1';
        end if;
      elsif estado_actual = IDLE or estado_actual = CONFIG then
          fase_actual_j0 <= '0';
          fase_actual_j1 <= '0';
      end if;
    end if;
  end process;

  process(estado_actual, config_sync, ini_pausa_sync, jugador_act_sync, modo_sync, min_value_j0, min_value_j1, mov_j0_gt40, mov_j1_gt40, fase_actual_j0, fase_actual_j1, min_value_1hora_j0, min_value_1hora_j1, mov_j0_gt_16, mov_j1_gt_16, bonus_sync)
  begin
    -- Default values
    estado_siguiente <= estado_actual;
    load2 <= '0';
    loadbonus <= '0';
    pierde_j0 <= '0';
    pierde_j1 <= '0';
    borrar_j0 <= '0';
    borrar_j1 <= '0';
    ini_pausa_j0 <= '0';
    ini_pausa_j1 <= '0';
    en_sel <= '0';
    en_j0 <= '0';
    en_j1 <= '0';

    case estado_actual is
      when IDLE =>
        borrar_j0 <= '1';
        borrar_j1 <= '1';
        if config_sync = '1' then 
            estado_siguiente <= CONFIG; 
        else
            estado_siguiente <= IDLE;
        end if;

      when CONFIG =>
        en_sel <= '1';
        load2 <= '1';
        if config_sync = '0' then 
            estado_siguiente <= PLAY; 
        else
            estado_siguiente <= CONFIG;
        end if;

      when PLAY =>
        if jugador_act_sync = '0' then
            ini_pausa_j0 <= '1';
            ini_pausa_j1 <= '0';
            en_j0 <= '1';
            en_j1 <= '0';
        else
            ini_pausa_j0 <= '0';
            ini_pausa_j1 <= '1';
            en_j0 <= '0';
            en_j1 <= '1';
        end if;

        if bonus_sync = '1' then
            loadbonus <= '1';
        end if;

        if min_value_j0 = '1' then
            pierde_j0 <= '1';
            estado_siguiente <= GAME_OVER;
        elsif min_value_j1 = '1' then
            pierde_j1 <= '1';
            estado_siguiente <= GAME_OVER;
        end if;

        if modo_sync = "10" then
          if (fase_actual_j0 = '1' and min_value_1hora_j0 = '1' and mov_j0_gt_16 = '0') then
            pierde_j0 <= '1';
            estado_siguiente <= GAME_OVER;
          elsif (fase_actual_j1 = '1' and min_value_1hora_j1 = '1' and mov_j1_gt_16 = '0') then
            pierde_j1 <= '1';
            estado_siguiente <= GAME_OVER;
          end if;
        end if;

        if ini_pausa_sync = '0' then 
            estado_siguiente <= PAUSE; 
        end if;

      when PAUSE =>
        ini_pausa_j0 <= '0';
        ini_pausa_j1 <= '0';
        if ini_pausa_sync = '1' then 
            estado_siguiente <= PLAY; 
        else
            estado_siguiente <= PAUSE;
        end if;

      when GAME_OVER =>
        borrar_j0 <= '1';
        borrar_j1 <= '1';
        if config_sync = '1' then 
            estado_siguiente <= IDLE; 
        else
            estado_siguiente <= GAME_OVER;
        end if;
    end case;
  end process;
end structural;