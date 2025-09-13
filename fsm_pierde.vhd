-- Descripción:
-- estados cuando pierden

library ieee;
use ieee.std_logic_1164.all;

entity fsm_pierde is
	port(clk, reset_n, pierde_j0,pierde_j1:in std_logic;
		leds_0:out std_logic_vector(9 downto 0));
end fsm_pierde;

architecture fsm_pierde of fsm_pierde is
	component divisor_freq
		generic (N         : natural := 50000000;        
           BUS_WIDTH : natural := 26);
		port(signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal clk_o   : out std_logic);
	
	end component;
	
	type estados is (ledj0_0,ledj0_1,ledj1_0,ledj1_1,inicio);
	signal estado_sgte, estado_pte: estados;
	signal clk_o:std_logic;
	begin
	
	frecuencia: divisor_freq generic map(N=>50000000, BUS_WIDTH => 26) port map(reset_n=>reset_n, clk=>clk, clk_o=>clk_o);
	
	resetear_1: process(reset_n, clk_o)
	  begin
		 if (reset_n = '0') then
			estado_pte <= inicio;
		 elsif rising_edge(clk_o) then
			estado_pte <= estado_sgte;
		 end if;
	  end process;
	  
	  	  pierde: process(estado_pte, pierde_j0,pierde_j1)
	  begin 
	  case estado_pte is
	  
	  when inicio=>
	  leds_0(9 downto 5)<="00000";
	  leds_0(4 downto 0)<="00000";
	  if pierde_j0='1' then estado_sgte<=ledj0_0;
	  elsif pierde_j1='1' then estado_sgte<=ledj1_0;
	  else estado_sgte<= inicio;
		end if;
		
		when ledj0_0=>
		leds_0(9 downto 5)<="10101";
	  leds_0(4 downto 0)<="00000";
	  estado_sgte<=ledj0_1;
	  
	  when ledj0_1=>
	  leds_0(9 downto 5)<="01010";
	  leds_0(4 downto 0)<="00000";
	  estado_sgte<=ledj0_0;
	  
	  when ledj1_0=>
		leds_0(9 downto 5)<="00000";
	  leds_0(4 downto 0)<="10101";
	  estado_sgte<=ledj1_1;
	  
	  when ledj1_1=>
	  leds_0(9 downto 5)<="00000";
	  leds_0(4 downto 0)<="01010";
	  estado_sgte<=ledj1_0;
	 end case;
	 end process;
	  
end fsm_pierde;