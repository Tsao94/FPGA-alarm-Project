LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity compare is
port( hr0_in: in std_logic_vector (3 downto 0);
		hr1_in: in std_logic_vector (1 downto 0);
		min0_in: in std_logic_vector (3 downto 0);
		min1_in: in std_logic_vector (2 downto 0);
		
		hr0_in_alarm: in std_logic_vector (3 downto 0);
		hr1_in_alarm: in std_logic_vector (1 downto 0);
		min0_in_alarm: in std_logic_vector (3 downto 0);
		min1_in_alarm: in std_logic_vector (2 downto 0);
		
		LED_ind: out std_logic
		
		);
end entity compare;

architecture cmp_bhv of compare is
	signal led_tmp: std_logic:='0';
	
	begin

	process(hr0_in, hr0_in_alarm, hr1_in, hr1_in_alarm, min0_in, min0_in_alarm, min1_in, min1_in_alarm, led_tmp)
	begin
		if (hr0_in=hr0_in_alarm and hr1_in=hr1_in_alarm and min0_in=min0_in_alarm and min1_in=min1_in_alarm) then
			led_tmp<='1';
		else
			led_tmp<='0';
		end if;
		LED_ind<=led_tmp;
	end process;


end architecture cmp_bhv;