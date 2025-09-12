library ieee;
use ieee.std_logic_1164.all;

package component_reloj_ajedrez is
    component divisor_freq
        generic (
            N         : natural := 50000000;
            BUS_WIDTH : natural := 26
        );
        port (
            reset_n : in  std_logic;
            clk     : in  std_logic;
            clk_o   : out std_logic
        );
    end component;

    component sincronizador
        port (
            reset_n         : in  std_logic;
            config          : in  std_logic;
            clk             : in  std_logic;
            ini_pausa       : in  std_logic;
            jugador_act     : in  std_logic;
            bonus           : in  std_logic;
            modo            : in  std_logic_vector(1 downto 0);
            ver_disp        : in  std_logic_vector(1 downto 0);
            config_sync     : out std_logic;
            ini_pausa_sync  : out std_logic;
            jugador_act_sync: out std_logic;
            bonus_sync      : out std_logic;
            modo_sync       : out std_logic_vector(1 downto 0);
            ver_disp_sync   : out std_logic_vector(1 downto 0)
        );
    end component;

    component fsm
        port (
            clk, reset_n, en, config_sync, ini_pausa_sync, jugador_act_sync,
            min_value_j0, min_value_j1, mov_j0_gt40, mov_j1_gt40,
            mov_j0_gt_16, mov_j1_gt_16, min_value_1hora_j0, min_value_1hora_j1, bonus_sync: in std_logic;
            modo_sync       : in  std_logic_vector(1 downto 0);
            ini_pausa_j0    : out std_logic;
            borrar_j0       : out std_logic;
            ini_pausa_j1    : out std_logic;
            borrar_j1       : out std_logic;
            en_sel          : out std_logic;
            en_j0           : out std_logic;
            en_j1           : out std_logic;
            load2           : out std_logic;
            loadbonus       : out std_logic;
            pierde_j0       : out std_logic;
            pierde_j1       : out std_logic
        );
    end component;

    component cont_mov_j
        port (
            clk, reset_n, entrada_j : in  std_logic;
            mov_j_gt40              : out std_logic;
            mov_c_j, mov_d_j, mov_u_j: out std_logic_vector(6 downto 0)
        );
    end component;

    component Contador255
        generic(M_INICIAL : natural := 40);
        port(
            clk, reset_n: in std_logic;
            entrada_j: in std_logic;
            umbral_dinamico: in natural;
            mov_out: out std_logic_vector(7 downto 0);
            mov_j_gt_umbral: out std_logic
        );
    end component;

    component fsm_pierde
        port (
            clk, reset_n, pierde_j0, pierde_j1: in  std_logic;
            leds_0                            : out std_logic_vector(9 downto 0)
        );
    end component;

    component reg_d1
        port (
            reset_n     : in  std_logic;
            clk         : in  std_logic;
            en_sel      : in  std_logic;
            modo_sync   : in  std_logic_vector(1 downto 0);
            sel         : out std_logic_vector(2 downto 0)
        );
    end component;

    component mux4a1
        port (
            a, b, c, d  : in  std_logic_vector(6 downto 0);
            sel         : in  std_logic_vector(1 downto 0);
            f           : out std_logic_vector(6 downto 0)
        );
    end component;
end package;