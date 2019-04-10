LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX is
port(
		hr0_in: in std_logic_vector (3 downto 0);
		hr1_in: in std_logic_vector (1 downto 0);
		min0_in: in std_logic_vector (3 downto 0);
		min1_in: in std_logic_vector (2 downto 0);
		s0_in: in std_LOGIC_vector(3 downto 0);
		s1_in: in std_LOGIC_vector(2 downto 0);
		
		hr0_in_alarm: in std_logic_vector (3 downto 0);
		hr1_in_alarm: in std_logic_vector (1 downto 0);
		min0_in_alarm: in std_logic_vector (3 downto 0);
		min1_in_alarm: in std_logic_vector (2 downto 0);
		
		seg1_alarm : OUT STD_LOGIC_VECTOR(7 downto 0);
		seg2_alarm : OUT STD_LOGIC_VECTOR(7 downto 0);
		seg3_alarm : OUT STD_LOGIC_VECTOR(7 downto 0);
		seg4_alarm : OUT STD_LOGIC_VECTOR(7 downto 0);
		seg5_alarm : OUT STD_LOGIC_VECTOR(7 downto 0);
		seg6_alarm : OUT STD_LOGIC_VECTOR(7 downto 0);
		
		mode_in_mux: in std_logic
		
		);
end entity MUX;

architecture bhv_mux of MUX is
	signal sls1 :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal sms1 :   STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal mls1 :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal mms1 :   STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal hls1 :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal hms1 :   STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	
	begin

process(hr0_in, hr1_in, min0_in, min1_in, s0_in, s1_in, min1_in_alarm, min0_in_alarm, hr1_in_alarm, hr0_in_alarm, mode_in_mux) begin
	
	if (mode_in_mux='0') then
	
		hms1<=hr1_in;
		hls1<=hr0_in;
		mms1<=min1_in;
		mls1<=min0_in;
		sms1<=s1_in;
		sls1<=s0_in;

	else
	
		hms1<=hr1_in_alarm;
		hls1<=hr0_in_alarm;
		mms1<=min1_in_alarm;
		mls1<=min0_in_alarm;
		
	end if;
	
end process;

PROCESS (sms1)
		BEGIN
			CASE sms1 IS 
				WHEN "000" => seg2_alarm <= x"30";--"0000001";
				WHEN "001" => seg2_alarm <= x"31";--"1001111";
				WHEN "010" => seg2_alarm <= x"32";--"0010010";
				WHEN "011" => seg2_alarm <= x"33";--'"0000110";
				WHEN "100" => seg2_alarm <= x"34";--"1001100";
				WHEN "101" => seg2_alarm <= x"35";--"0100100";
				WHEN OTHERS => seg2_alarm <= x"30";--"0000001";
			END CASE;
	END PROCESS;
	-- For the LS of the second
	PROCESS (sls1)
		BEGIN
			CASE sls1 IS 
				 WHEN "0000" => seg1_alarm <= x"30";--"0000001";
				 WHEN "0001" => seg1_alarm <= x"31";--"1001111";
				 WHEN "0010" => seg1_alarm <= x"32";--"0010010";
				 WHEN "0011" => seg1_alarm <= x"33";--"0000110";
				 WHEN "0100" => seg1_alarm <= x"34";--"1001100";
				 WHEN "0101" => seg1_alarm <= x"35";--"0100100";
				 WHEN "0110" => seg1_alarm <= x"36";--"0100000";
				 WHEN "0111" => seg1_alarm <= x"37";--"0001111";
				 WHEN "1000" => seg1_alarm <= x"38";--"0000000";
				 WHEN "1001" => seg1_alarm <= x"39";--"0000100";
				 WHEN OTHERS => seg1_alarm <= x"30";--"0000001";
			END CASE;
	END PROCESS;	
	
	--- For the MS of the Second
	PROCESS (mms1)
		BEGIN
			CASE mms1 IS 
				WHEN "000" => seg4_alarm <= x"30";--"0000001";
				WHEN "001" => seg4_alarm <= x"31";--"1001111";
				WHEN "010" => seg4_alarm <= x"32";--"0010010";
				WHEN "011" => seg4_alarm <= x"33";--"0000110";
				WHEN "100" => seg4_alarm <= x"34";--"1001100";
				WHEN "101" => seg4_alarm <= x"35";--"0100100";
				WHEN OTHERS => seg4_alarm <= x"36";--"0000001";
			END CASE;
	END PROCESS;
	
	-- For the LS of the second
	PROCESS (mls1)
		BEGIN
		CASE mls1 IS 
			 WHEN "0000" => seg3_alarm <= x"30";--"0000001";
			 WHEN "0001" => seg3_alarm <= x"31";--"1001111";
			 WHEN "0010" => seg3_alarm <= x"32";--"0010010";
			 WHEN "0011" => seg3_alarm <= x"33";--"0000110";
			 WHEN "0100" => seg3_alarm <= x"34";--"1001100";
			 WHEN "0101" => seg3_alarm <= x"35";--"0100100";
			 WHEN "0110" => seg3_alarm <= x"36";--"0100000";
			 WHEN "0111" => seg3_alarm <= x"37";--"0001111";
			 WHEN "1000" => seg3_alarm <= x"38";--"0000000";
			 WHEN "1001" => seg3_alarm <= x"39";--"0000100";
			 WHEN OTHERS => seg3_alarm <= x"30";--"0000001";		
		 END CASE;
	END PROCESS;	
	
	--For the MS of the hour hand
	PROCESS(hms1)
		BEGIN
			CASE hms1 IS 
				WHEN "00" => seg6_alarm <= x"30";--"0000001";
				WHEN "01" => seg6_alarm <= x"31";--"1001111";
				WHEN "10" => seg6_alarm <= x"32";--"0010010";
				WHEN OTHERS => seg6_alarm <= x"30";--"0000001";
			END CASE;
	END PROCESS;
	
	-- For the LS of the hour hand
	PROCESS(hls1)
		BEGIN
			CASE hls1 IS
			 WHEN "0000" => seg5_alarm <= x"30";--"0000001";
			 WHEN "0001" => seg5_alarm <= x"31";--"1001111";
			 WHEN "0010" => seg5_alarm <= x"32";--"0010010";
			 WHEN "0011" => seg5_alarm <= x"33";--"0000110";
			 WHEN "0100" => seg5_alarm <= x"34";--"1001100";
			 WHEN "0101" => seg5_alarm <= x"35";--"0100100";
			 WHEN "0110" => seg5_alarm <= x"36";--"0100000";
			 WHEN "0111" => seg5_alarm <= x"37";--"0001111";
			 WHEN "1000" => seg5_alarm <= x"38";--"0000000";
			 WHEN "1001" => seg5_alarm <= x"39";--"0000100";
			 WHEN OTHERS => seg5_alarm <= x"30";--"0000001";
			END CASE;
	END PROCESS;

end architecture bhv_mux;




