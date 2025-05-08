-- Descripción:
--contar segundos, minutos, horas, mostrar cuando llega al mínimo, salidas display que están en decimal

library ieee;
use ieee.std_logic_1164.all;
use work.component_reloj.all;
use ieee.numeric_std.all;

entity reloj is
  generic (N         : natural := 50000000;        
           BUS_WIDTH : natural := 26;
			  N1        : natural := 6;
			  N2        : natural := 2
			  );
  port(signal clk, reset_n, ini_pausa, borrar, load1, loadbonus: in std_logic;
		signal sel:in std_logic_vector(2 downto 0);
		signal Manual_hour: in std_logic_vector(1 downto 0);
		signal Manual_min, Manual_seg: in std_logic_vector(5 downto 0);
		signal display_3, display_2, display_1, display_0,display_4,display_5: out std_logic_vector(6 downto 0);
		signal min_value, min_value_1hora: out std_logic
	    );
end reloj;

architecture reloj of reloj is
  signal clk_en : std_logic;
  signal en_seg : std_logic;
  signal g_reset_n : std_logic;
  signal seg : std_logic_vector(5 downto 0);
  signal bintobcd_sec : std_logic_vector(7 downto 0);
  signal bintobcd_min : std_logic_vector(7 downto 0);
  signal bintobcd_hour : std_logic_vector(7 downto 0);
  signal min_seg : std_logic;
  signal en_min : std_logic;
  signal min : std_logic_vector(5 downto 0);
  signal min_in : std_logic_vector(5 downto 0);
  signal min_min : std_logic;
  signal min_hour : std_logic;
  signal en_hour : std_logic;
  signal hour : std_logic_vector(1 downto 0);
  signal hour_in : std_logic_vector(5 downto 0);
  signal load: std_logic;
  signal data_seg: std_logic_vector(5 downto 0);
  signal data_min: std_logic_vector(5 downto 0);
  signal data_hour: std_logic_vector(1 downto 0);


begin
	
	div: divisor_freq generic map(N=>N,
                                 BUS_WIDTH=>BUS_WIDTH)
                        port map(reset_n => reset_n,
                                 clk => clk,
											clk_o=>clk_en);
											
	g_reset_n <= (not(borrar) or ini_pausa) and reset_n;
	
	en_seg <= clk_en and ini_pausa;
	min_value_1hora <= min_min and min_seg and min_hour;
	min_value <= min_min and min_seg and min_hour;
	
	--contador segundos
	cont_60: counter_mod_seg port map(clk=>clk,
												g_reset_n=>g_reset_n,
												en_seg=>en_seg,
												seg=>seg,
												load=>load,
												data=>data_seg);
													
	comp1: comparador port map(A =>seg,
										B => "000000",
										EQ => min_seg);
	bin1: bintobcd port map(a =>seg,
									f =>bintobcd_sec);
	hexa_1 : hexa port map(a=>bintobcd_sec(7 downto 4),
                         f=>display_1);
								 
   hexa_2 : hexa port map(a=>bintobcd_sec(3 downto 0),
                         f=>display_0);
	
	en_min <= en_seg and min_seg;
	
	--contador minutos
	cont_min: counter_mod_min port map(clk=>clk,
												g_reset_n=>g_reset_n,
												en_min=>en_min,
												min=>min,
												load=>load,
												data=>data_min);
													
	comp2: comparador generic map(N=>N1) port map(A =>min,
										B => "000000",
										EQ => min_min);
	min_in <= min;
	
	bin2: bintobcd port map(a =>min_in,
									f =>bintobcd_min);
	hexa_3 : hexa port map(a=>bintobcd_min(7 downto 4),
                         f=>display_3);
	
   hexa_4 : hexa port map(a=>bintobcd_min(3 downto 0),
                         f=>display_2);
	en_hour<= en_min and min_min;
	
	--contador horas
	cont_2: counter_mod_hour port map(clk=>clk,
												g_reset_n=>g_reset_n,
												en_hour=>en_hour,
												hour=>hour,
												load=>load,
												data=>data_hour);
	comp3: comparador generic map(N=>N2) port map(A =>hour,
										B => "00",
										EQ => min_hour);
	hour_in <="0000" & hour;
	bin3: bintobcd port map(a =>hour_in,
									f =>bintobcd_hour);
	hexa_5 : hexa port map(a=>bintobcd_hour(7 downto 4),
                         f=>display_5);
	
	hexa_6 : hexa port map(a=>bintobcd_hour(3 downto 0),
                         f=>display_4);


	process (sel, data_seg, data_min, data_hour, load, load1,loadbonus,Manual_hour,Manual_min,Manual_seg)
		begin
			if sel = "000" then data_hour<="00";
										data_min<="000101";
										data_seg<="000000";
										load<=load1;
			elsif sel = "001" then data_hour<="00";
										data_min<="011001";
										data_seg<="000000";
										load<=load1;
			elsif sel = "010" then 
				if loadbonus='1' then
				data_hour<="01";
				data_min<="000000";
				data_seg<="000000";
				load<=loadbonus;
				else data_hour<="10";
				data_min<="000000";
				data_seg<="000000";
				load<=load1;
				end if;
			elsif sel = "011" then data_hour<=Manual_hour;
										data_min<=Manual_min;
										data_seg<=Manual_seg;
										load<=load1;
			else  data_hour<="00";
					data_min<="000000";
					data_seg<="000000";
					load<=load1;
			end if;
	end process;

end reloj;