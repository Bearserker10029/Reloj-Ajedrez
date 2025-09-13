## Reloj Ajedrez
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/Bearserker10029/Reloj-Ajedrez)

### Señales del Módulo `reloj_ajedrez`

| Señal | Dirección | Ancho (bits) | Descripción |
| :--- | :--- | :--- | :--- |
| `reset_n` | entrada | 1 | Señal de reinicio asíncrono activo en baja. Cuando está activo los visualizadores de 7 segmentos (displays) deberán estar inactivos. |
| `clk` | entrada | 1 | Señal de reloj de 50 MHz, a ser usada por flanco de subida. |
| `config` | entrada | 1 | Señal que cuando vale 1 lógico permitirá la configuración del modo de funcionamiento del reloj de ajedrez. |
| `ini_pausa` | entrada | 1 | Señal que cuando vale 1 lógico hará iniciar la cuenta, caso contrario, la cuenta estará en pausa para ambos jugadores. |
| `jugador_act` | entrada | 1 | Señal que cuando vale 0 lógico permite que el jugador activo sea el jugador 0 y cuando vale 1 lógico el jugador activo será el jugador 1. |
| `modo` | entrada | 2 | Se tiene las siguientes opciones para definir el modo:<br>00 -> Blitz<br>01 -> Rapid<br>10 -> Word Chess Championship Match<br>11 ->Manual |
| `bonus` | entrada | 1 | Señal que cuando vale 1 lógico permitirá la adición de un tiempo, al terminar el tiempo oficial, solamente para Blitz, Rapid y Manual. |
| `ver_disp` | entrada | 2 | Se tiene las siguientes opciones para visualizar en los visualizadores de 7 segmentos lo siguiente:<br>00 -> tiempo del jugador 0 (hh:mm:ss)<br>01 -> cantidad de movimientos del jugador 0<br>10 -> tiempo del jugador 1 (hh:mm:ss)<br>11 -> cantidad de movimientos del jugador 1 |
| `display_0` | salida | 7 | Salida correspondiente a las unidades de segundo. |
| `display_1` | salida | 7 | Salida correspondiente a las decenas de segundo. |
| `display_2` | salida | 7 | Salida correspondiente a las unidades de minuto. |
| `display_3` | salida | 7 | Salida correspondiente a las decenas de minuto. |
| `display_4` | salida | 7 | Salida correspondiente a las unidades de hora. |
| `display_5` | salida | 7 | Salida correspondiente a las decenas de hora. |
| `leds` | salida | 10 | Salida de 10 bits que sirve para indicar cuando un jugador perdió por tiempo. |