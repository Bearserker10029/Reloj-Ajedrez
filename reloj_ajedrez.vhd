library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.component_reloj_ajedrez.all;

entity reloj_ajedrez is
    generic (
        N         : natural := 500000;
        BUS_WIDTH : natural := 19
    );
    port (
        reset_n, clk, config, ini_pausa, jugador_act, bonus : in  std_logic;
        modo, ver_disp                                      : in  std_logic_vector(1 downto 0);
        Manual_hour                                         : in  std_logic_vector(1 downto 0);
        Manual_min, Manual_seg                              : in  std_logic_vector(5 downto 0);
        display0, display1, display2, display3, display4, display5: out std_logic_vector(6 downto 0);
        leds                                                : out std_logic_vector(9 downto 0)
    );
end reloj_ajedrez;

architecture reloj_ajedrez of reloj_ajedrez is
    -- Señales del sincronizador
    signal config_sync, ini_pausa_sync, jugador_act_sync, bonus_sync: std_logic;
    signal modo_sync, ver_disp_sync: std_logic_vector(1 downto 0);

    -- Señales de la FSM
    signal en, min_value_j0, min_value_j1, ini_pausa_j0, borrar_j0, ini_pausa_j1, borrar_j1: std_logic;
    signal en_sel, en_j0, en_j1, mov_j0_gt40, mov_j1_gt40, load3: std_logic;
    signal min_value_1hora_j0, min_value_1hora_j1, loadbonus, pierde_j0, pierde_j1: std_logic;

    -- Señales del reloj
    signal sel: std_logic_vector(2 downto 0);

    -- Señales de los jugadores
    signal display_0_j0, display_1_j0, display_2_j0, display_3_j0, display_4_j0, display_5_j0: std_logic_vector(6 downto 0);
    signal display_0_j1, display_1_j1, display_2_j1, display_3_j1, display_4_j1, display_5_j1: std_logic_vector(6 downto 0);

    -- Señales de los contadores de movimientos
    signal mov_u_j0, mov_u_j1, mov_d_j0, mov_d_j1, mov_c_j0, mov_c_j1: std_logic_vector(6 downto 0);
    signal entrada_j0, entrada_j1: std_logic;
    signal mov_j0_gt_16, mov_j1_gt_16: std_logic;

begin
    -- Divisor de frecuencia
    div_freq: divisor_freq
        generic map (N => N, BUS_WIDTH => BUS_WIDTH)
        port map (reset_n => reset_n, clk => clk, clk_o => en);

    -- Sincronizador de entradas
    sincro: sincronizador
        port map (
            reset_n         => reset_n,
            config          => config,
            clk             => clk,
            ini_pausa       => ini_pausa,
            jugador_act     => jugador_act,
            bonus           => bonus,
            modo            => modo,
            ver_disp        => ver_disp,
            config_sync     => config_sync,
            ini_pausa_sync  => ini_pausa_sync,
            jugador_act_sync=> jugador_act_sync,
            bonus_sync      => bonus_sync,
            modo_sync       => modo_sync,
            ver_disp_sync   => ver_disp_sync
        );

    -- Instancias de reloj para cada jugador
    relojjugador_0: entity work.reloj
        generic map (N => 50000000, BUS_WIDTH => 26, N1 => 6, N2 => 2)
        port map (
            clk               => clk,
            reset_n           => reset_n,
            Manual_hour       => Manual_hour,
            Manual_min        => Manual_min,
            Manual_seg        => Manual_seg,
            ini_pausa         => ini_pausa_j0,
            borrar            => borrar_j0,
            sel               => sel,
            min_value         => min_value_j0,
            min_value_1hora   => min_value_1hora_j0,
            display_0         => display_0_j0,
            display_1         => display_1_j0,
            display_2         => display_2_j0,
            display_3         => display_3_j0,
            display_4         => display_4_j0,
            display_5         => display_5_j0,
            load1             => load3,
            loadbonus         => loadbonus
        );

    relojjugador_1: entity work.reloj
        generic map (N => 50000000, BUS_WIDTH => 26, N1 => 6, N2 => 2)
        port map (
            clk               => clk,
            reset_n           => reset_n,
            Manual_hour       => Manual_hour,
            Manual_min        => Manual_min,
            Manual_seg        => Manual_seg,
            ini_pausa         => ini_pausa_j1,
            borrar            => borrar_j1,
            sel               => sel,
            min_value         => min_value_j1,
            min_value_1hora   => min_value_1hora_j1,
            display_0         => display_0_j1,
            display_1         => display_1_j1,
            display_2         => display_2_j1,
            display_3         => display_3_j1,
            display_4         => display_4_j1,
            display_5         => display_5_j1,
            load1             => load3,
            loadbonus         => loadbonus
        );

    -- FSM principal
    fsm1: fsm
        port map (
            clk                 => clk,
            reset_n             => reset_n,
            en                  => en,
            config_sync         => config_sync,
            ini_pausa_sync      => ini_pausa_sync,
            jugador_act_sync    => jugador_act_sync,
            modo_sync           => modo_sync,
            min_value_j0        => min_value_j0,
            min_value_j1        => min_value_j1,
            min_value_1hora_j0  => min_value_1hora_j0,
            min_value_1hora_j1  => min_value_1hora_j1,
            mov_j0_gt40         => mov_j0_gt40,
            mov_j1_gt40         => mov_j1_gt40,
            mov_j0_gt_16        => mov_j0_gt_16,
            mov_j1_gt_16        => mov_j1_gt_16,
            ini_pausa_j0        => ini_pausa_j0,
            borrar_j0           => borrar_j0,
            ini_pausa_j1        => ini_pausa_j1,
            borrar_j1           => borrar_j1,
            en_sel              => en_sel,
            en_j0               => en_j0,
            en_j1               => en_j1,
            load2               => load3,
            loadbonus           => loadbonus,
            pierde_j0           => pierde_j0,
            pierde_j1           => pierde_j1,
            bonus_sync          => bonus_sync
        );

    -- Registro para selección de modo
    reg: reg_d1
        port map (
            reset_n => reset_n,
            clk     => clk,
            en_sel  => en_sel,
            modo_sync => modo_sync,
            sel     => sel
        );

    -- Multiplexores para displays
    disp0: mux4a1 port map (a => display_0_j0, b => mov_u_j0, c => display_0_j1, d => mov_u_j1, sel => ver_disp_sync, f => display0);
    disp1: mux4a1 port map (a => display_1_j0, b => mov_d_j0, c => display_1_j1, d => mov_d_j1, sel => ver_disp_sync, f => display1);
    disp2: mux4a1 port map (a => display_2_j0, b => mov_c_j0, c => display_2_j1, d => mov_c_j1, sel => ver_disp_sync, f => display2);
    disp3: mux4a1 port map (a => display_3_j0, b => "1111111", c => display_3_j1, d => "1111111", sel => ver_disp_sync, f => display3);
    disp4: mux4a1 port map (a => display_4_j0, b => "1111111", c => display_4_j1, d => "1111111", sel => ver_disp_sync, f => display4);
    disp5: mux4a1 port map (a => display_5_j0, b => "1111111", c => display_5_j1, d => "1111111", sel => ver_disp_sync, f => display5);

    -- Contadores de movimientos
    contadorj0: cont_mov_j port map (clk => clk, reset_n => reset_n, entrada_j => entrada_j0, mov_j_gt40 => mov_j0_gt40, mov_c_j => mov_c_j0, mov_d_j => mov_d_j0, mov_u_j => mov_u_j0);
    contadorj1: cont_mov_j port map (clk => clk, reset_n => reset_n, entrada_j => entrada_j1, mov_j_gt40 => mov_j1_gt40, mov_c_j => mov_c_j1, mov_d_j => mov_d_j1, mov_u_j => mov_u_j1);

    -- Contadores para 16 movimientos (fase posterior)
    contar16movj0: entity work.Contador255 generic map (M_INICIAL => 16) port map (clk => clk, reset_n => reset_n, entrada_j => entrada_j0, umbral_dinamico => 16, mov_out => open, mov_j_gt_umbral  => mov_j0_gt_16);
    contar16movj1: entity work.Contador255 generic map (M_INICIAL => 16) port map (clk => clk, reset_n => reset_n, entrada_j => entrada_j1, umbral_dinamico => 16, mov_out => open, mov_j_gt_umbral  => mov_j1_gt_16);

    -- FSM para control de LEDs
    fsmpierde1: fsm_pierde port map (clk => clk, reset_n => reset_n, pierde_j0 => pierde_j0, pierde_j1 => pierde_j1, leds_0 => leds);

    -- Lógica de habilitación de contadores
    entrada_j0 <= en and en_j0;
    entrada_j1 <= en and en_j1;

end reloj_ajedrez;