library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity State_Monitoring_System is
    Port ( clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           fan_control  : in  STD_LOGIC;
           light_control: in  STD_LOGIC;
           alarm_control: in  STD_LOGIC;
           current_state: out String(1 to 16));  -- 2-bit state
end State_Monitoring_System;

architecture Behavioral of State_Monitoring_System is
    type state_type is (Idle, Device_Control, Alarm_Activated);
    signal state, next_state: state_type;
begin
    process(clk, reset)
    begin	
	state <= idle;
        if reset = '1' then
            state <= Idle;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    process(state, fan_control, light_control, alarm_control)
    begin
        case state is
            when Idle =>
                if fan_control = '1' or light_control = '1' then
                    next_state <= Device_Control;
                else
                    next_state <= Idle;
                end if;

            when Device_Control =>
                if alarm_control = '1' then
                    next_state <= Alarm_Activated;
                else
                    next_state <= Device_Control;
                end if;

            when Alarm_Activated =>
                next_state <= Idle;

            when others =>
                next_state <= Idle;
        end case;
	
    -- Output state as 2-bit value
	case state is
		when Idle =>
		    current_state <= "Idle            ";
		when Device_Control =>
		    current_state <= "DeviceControl   ";
		when Alarm_Activated =>
		    current_state <= "AlarmActivated  ";

	end case;
    end process;
end Behavioral;
