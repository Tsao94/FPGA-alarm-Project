LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alarm is
port(
		clock_100_in : in std_logic;
		nreset: in std_logic;
		set_in: in std_logic;
		mode_in: in std_logic;
		pb_min_alarm: in std_logic;
		pb_hr_alarm: in std_logic;
		hr0_out_alarm: out std_logic_vector(3 downto 0);
		hr1_out_alarm: out std_LOGIC_VECTOR(1 downto 0);
		min0_out_alarm: out std_LOGIC_VECTOR(3 downto 0);
		min1_out_alarm: out std_LOGIC_VECTOR(2 downto 0)
		
		);
end entity alarm;

architecture bhv_alarm of alarm is

	 signal h_ms_int_alarm : integer range 0 to 2;
    signal h_ls_int_alarm : integer range 0 to 9;
    signal m_ms_int_alarm : integer range 0 to 5;
    signal m_ls_int_alarm : integer range 0 to 9;
    
	 
	signal mls_alarm :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal mms_alarm :   STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal hls_alarm :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal hms_alarm :   STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	begin
	
	process(set_in, clock_100_in, nreset, h_ms_int_alarm, h_ls_int_alarm, m_ms_int_alarm, m_ls_int_alarm, mode_in, pb_min_alarm, pb_hr_alarm)
	begin
	
		if (nreset='1') then
			h_ms_int_alarm <= 0;
         h_ls_int_alarm <= 0;
         m_ms_int_alarm <= 0;
			m_ls_int_alarm <= 0;
         
		elsif (mode_in='1' ) then
		if (clock_100_in'event and clock_100_in='1') then
			if pb_min_alarm='0' then
                m_ls_int_alarm<=m_ls_int_alarm + 1;
                if m_ls_int_alarm=9 then
                    m_ls_int_alarm<=0;
                    m_ms_int_alarm<=m_ms_int_alarm+1; 	
                end if;
            end if;
            if pb_hr_alarm='0' then
                h_ls_int_alarm<=h_ls_int_alarm+1;
					 if h_ls_int_alarm=9 then
						h_ls_int_alarm<=0;
                  h_ms_int_alarm<=h_ms_int_alarm+1;
					 end if;
					 if (h_ms_int_alarm=2 and h_ls_int_alarm=3) then
						h_ms_int_alarm<=0;
						h_ls_int_alarm<=0;
					 end if;
            end if;
				end if;
        end if;
				 
						
							
		hms_alarm <= std_logic_vector(to_unsigned(h_ms_int_alarm, hms_alarm'length));
		hls_alarm <= std_logic_vector(to_unsigned(h_ls_int_alarm, hls_alarm'length));
		mms_alarm <= std_logic_vector(to_unsigned(m_ms_int_alarm, mms_alarm'length));
		mls_alarm <= std_logic_vector(to_unsigned(m_ls_int_alarm, mls_alarm'length));
				
		hr0_out_alarm <= std_LOGIC_VECTOR(to_unsigned(h_ls_int_alarm, hls_alarm'length));
		hr1_out_alarm <= std_LOGIC_VECTOR(to_unsigned(h_ms_int_alarm, hms_alarm'length));
		min0_out_alarm <= std_LOGIC_VECTOR(to_unsigned(m_ls_int_alarm, mls_alarm'length));
		min1_out_alarm <= std_LOGIC_VECTOR(to_unsigned(m_ms_int_alarm, mms_alarm'length));
		end process alarm;
		
		

end architecture bhv_alarm;