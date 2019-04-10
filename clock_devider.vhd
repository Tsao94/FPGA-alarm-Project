library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;

entity clock_devider is
port(
		clk_in: in std_logic;
		clk_1hz: out std_logic;
		clk_400hz: out std_logic;
		clk_100hz: out std_logic
		);
end clock_devider;

architecture bhv of clock_devider is
	signal clk_tmp, clk_tmp_100 , clk_tmp_400: std_logic :='0';
	signal count : integer :=0;

	begin
	 process (clk_in, clk_tmp, clk_tmp_100, clk_tmp_400) begin
		if (rising_edge(clk_in)) then
			count <= count +1;
			if (count = 2500000) then
				clk_tmp_100 <= not clk_tmp_100;
			end if;
			if (count = 125000) then
				clk_tmp_400<= not clk_tmp_400;
			end if;
			if (count = 2500000) then
				clk_tmp <= not clk_tmp;
				count <= 0;
			end if;
		end if;
		clk_1hz <= clk_tmp;
		clk_100hz <= clk_tmp_100;
		clk_400hz <=clk_tmp_400;
	end process;
end architecture bhv;