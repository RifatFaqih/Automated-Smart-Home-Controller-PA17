library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Alarm_System is
    Port ( clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           alarm_trigger: in  STD_LOGIC;
           alarm_active : out STD_LOGIC);
end Alarm_System;

architecture Behavioral of Alarm_System is
    -- Procedure to activate alarm
    procedure activate_alarm(signal alarm_signal : out STD_LOGIC) is
    begin
        alarm_signal <= '1';
    end procedure;

begin
    process(clk, reset)
    begin
        if reset = '1' then
            alarm_active <= '0';
        elsif rising_edge(clk) then
            if alarm_trigger = '1' then
                activate_alarm(alarm_active);  -- Aktifkan alarm
            else
                alarm_active <= '0';  -- Matikan alarm
            end if;
        end if;
    end process;
end Behavioral;
