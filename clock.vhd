LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock is
port(
		clock_1s_in: in std_logic;
		clock_100s_in: in std_logic;
		pb_min: in std_logic;
		pb_hr: in std_logic;
		nreset: in std_logic;
		mode_in_clock: in std_logic;
		set_switch:in std_logic;
		hr0_out: out std_LOGIC_VECTOR(3 downto 0);
		hr1_out: out std_LOGIC_VECTOR(1 downto 0);
		min0_out: out std_LOGIC_VECTOR(3 downto 0);
		min1_out: out std_LOGIC_VECTOR(2 downto 0);
		s0_out: out std_LOGIC_VECTOR(3 downto 0);
		s1_out: out std_LOGIC_VECTOR(2 downto 0)
		
		
		);
end entity clock;

architecture bhv_clk of clock is

	 signal h_ms_int : integer range 0 to 2;
    signal h_ls_int : integer range 0 to 9;
    signal m_ms_int : integer range 0 to 5;
    signal m_ls_int : integer range 0 to 9;
    signal s_ms_int : integer range 0 to 5;
    signal s_ls_int : integer range 0 to 9;
	 
	signal sls :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal sms :   STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal mls :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal mms :   STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal hls :   STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal hms :   STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	begin
	
	-- Process that handles the project logic
        clk_proc : process(clock_1s_in, nreset, h_ms_int, h_ls_int, m_ms_int, m_ls_int, s_ms_int, s_ls_int, mode_in_clock)
            begin
            if nreset = '1' then
                h_ms_int <= 0;
                h_ls_int <= 0;
                m_ms_int <= 0;
                m_ls_int <= 0;
                s_ms_int <= 0;
                s_ls_int <= 0;
            elsif (clock_1s_in'event and clock_1s_in='1') then
                if s_ls_int = 9 then
                    if s_ms_int = 5 then
                        if (m_ls_int = 9) then
                            if (m_ms_int = 5 ) then
                                if (h_ls_int = 9 or (h_ls_int = 3 and h_ms_int = 2) ) then
                                    h_ls_int <= 0;
                                        if ((h_ls_int=3 and h_ms_int=2)) then
                                            h_ms_int <= 0;
                                            h_ls_int <= 0;
                                            m_ms_int <= 0;
                                            m_ls_int <= 0;
                                            s_ms_int <= 0;
                                            s_ls_int <= 0;
                                        else
                                           h_ms_int <= h_ms_int + 1;                                             
                                        end if;
                                    h_ls_int <= 0;
                                else
                                    h_ls_int <= h_ls_int + 1;                       
                                end if;
                                m_ms_int <= 0;
                            else
                                m_ms_int <= m_ms_int + 1;
                            end if;
                            m_ls_int <= 0;       
                        else
                            m_ls_int <= m_ls_int + 1;
                        end if;
                        s_ms_int <= 0;
                    else
                         s_ms_int <= s_ms_int + 1;     
                    end if;
                    s_ls_int <= 0;
                else
                     s_ls_int <= s_ls_int + 1;
                end if;
           
                        
        if ( mode_in_clock='0') then
            if pb_min='0' then
                m_ls_int<=m_ls_int + 1;
                s_ls_int<=0;
                s_ms_int<=0;
                if m_ls_int=9 then
                    m_ls_int<=0;
                    m_ms_int<=m_ms_int+1; 	
                end if;
            end if;
            if pb_hr='0' then
                h_ls_int<=h_ls_int+1;
                s_ls_int<=0;
                s_ms_int<=0;
					 if h_ls_int=9 then
						h_ls_int<=0;
                  h_ms_int<=h_ms_int+1;
					 end if;
					 if (h_ms_int=2 and h_ls_int=3) then
						h_ms_int<=0;
						h_ls_int<=0;
					 end if;
                 end if;
             end if;
        end if;
					
							

					
	
end process clk_proc;
	
	hr0_out <= std_LOGIC_VECTOR(to_unsigned(h_ls_int, hls'length));
	hr1_out <= std_LOGIC_VECTOR(to_unsigned(h_ms_int, hms'length));
	min0_out <= std_LOGIC_VECTOR(to_unsigned(m_ls_int, mls'length));
	min1_out <= std_LOGIC_VECTOR(to_unsigned(m_ms_int, mms'length));
	s0_out <= std_LOGIC_VECTOR(to_unsigned(s_ls_int,sls'length));
	s1_out <= std_LOGIC_VECTOR(to_unsigned(s_ms_int,sms'length));
	

end architecture;