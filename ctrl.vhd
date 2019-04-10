LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ctrl is
port(
		clock_1hz: in std_logic;
		clock_1hz_out: out std_logic;
		clock_100hz: in std_logic;
		clock_100hz_out: out std_logic;
		set: in std_logic;
		set_out : out std_logic;
		mode: in std_logic;
		mode_out : out std_logic;
		reset: in std_logic;
		reset_out: out std_logic;
		LED_indic: in std_logic;
		LED_out: out std_logic
		
		);
end entity ctrl;

architecture behaviour of ctrl is
	signal set_tmp, mode_tmp, reset_tmp: std_logic:='0';
	
begin

	
	process(set, clock_100hz, clock_1hz, set_tmp) begin
		if (set='1') then
			set_tmp<='1';
		else 
			clock_100hz_out<=clock_100hz;
			clock_1hz_out<=clock_1hz;
		end if;
		set_out<=set_tmp;		
	end process;
	
	process(mode, mode_tmp) begin
		if (mode='1') then
			mode_tmp<='1';
		else
			mode_tmp<='0';
		end if;
		mode_out<=mode_tmp;
	end process;
	
	process(reset, reset_tmp) begin
		if (reset='1') then
			reset_tmp<='1';
		else 
			reset_tmp<='0';
		end if;
		reset_out<=reset_tmp;
	end process;
	
	process(LED_indic) begin
		if (LED_indic='1') then
			LED_out<='1';
		else
			LED_out<='0';
		end if;
	end process;
	
end architecture behaviour;