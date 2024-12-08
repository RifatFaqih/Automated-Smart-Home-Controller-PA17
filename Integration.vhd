library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Top-level entity for Smart Home Controller
entity Smart_Home_Controller is
    Port ( clk           : in  STD_LOGIC;
           reset         : in  STD_LOGIC;
           temperature   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Suhu
           light_sensor  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Sensor Cahaya
           fan_control   : out STD_LOGIC;  -- Kontrol Kipas
           light_control : out STD_LOGIC;  -- Kontrol Lampu
           alarm_control : out STD_LOGIC;  -- Kontrol Alarm
           display       : out STD_LOGIC_VECTOR(6 downto 0)); -- Tampilan
end Smart_Home_Controller;

architecture Integrated of Smart_Home_Controller is

    -- Internal signals
    signal fan_signal        : STD_LOGIC;
    signal light_signal      : STD_LOGIC;
    signal alarm_signal      : STD_LOGIC;
    signal current_state     : STD_LOGIC_VECTOR(1 downto 0);
    signal alarm_active      : STD_LOGIC;

begin

    -- Device Control Module
    Device_Control: process(clk, reset)
    begin
        if reset = '1' then
            fan_control <= '0';
            light_control <= '0';
            alarm_control <= '0';
        elsif rising_edge(clk) then
            -- Fan control based on temperature
            if to_integer(unsigned(temperature)) > 30 then
                fan_control <= '1';
            else
                fan_control <= '0';
            end if;

            -- Light control based on light sensor
            if to_integer(unsigned(light_sensor)) < 50 then
                light_control <= '1';
            else
                light_control <= '0';
            end if;

            -- Alarm control based on temperature
            if to_integer(unsigned(temperature)) > 40 then
                alarm_control <= '1';
            else
                alarm_control <= '0';
            end if;
        end if;
    end process;

    -- State Monitoring System
    State_Monitoring: process(clk, reset, fan_signal, light_signal, alarm_signal)
        type state_type is (Idle, Device_Control, Alarm_Activated);
        variable state, next_state: state_type;
    begin
        if reset = '1' then
            state := Idle;
        elsif rising_edge(clk) then
            state := next_state;
        end if;

        -- State transitions
        case state is
            when Idle =>
                if fan_signal = '1' or light_signal = '1' then
                    next_state := Device_Control;
                else
                    next_state := Idle;
                end if;

            when Device_Control =>
                if alarm_signal = '1' then
                    next_state := Alarm_Activated;
                else
                    next_state := Device_Control;
                end if;

            when Alarm_Activated =>
                next_state := Idle;

            when others =>
                next_state := Idle;
        end case;

        -- Output state as 2-bit value
        current_state <= std_logic_vector(to_unsigned(state'pos(state), 2));
    end process;

    -- Environment Monitoring Module (Dataflow Style)
    fan_signal <= '1' when (to_integer(unsigned(temperature)) > 30) else '0';
    light_signal <= '1' when (to_integer(unsigned(light_sensor)) < 50) else '0';

    -- Automation Module
    Automation: process(clk, reset)
    begin
        if reset = '1' then
            fan_signal <= '0';
        elsif rising_edge(clk) then
            if to_integer(unsigned(temperature)) > 25 then
                fan_signal <= '1';
            else
                fan_signal <= '0';
            end if;
        end if;
    end process;

    -- Alarm System
    Alarm: process(clk, reset)
        procedure activate_alarm(signal alarm_signal : out STD_LOGIC) is
        begin
            alarm_signal <= '1';
        end procedure;
    begin
        if reset = '1' then
            alarm_active <= '0';
        elsif rising_edge(clk) then
            if alarm_signal = '1' then
                activate_alarm(alarm_active);
            else
                alarm_active <= '0';
            end if;
        end if;
    end process;

    -- Display System
    Display: process(clk, reset, fan_signal, light_signal)
    begin
        if reset = '1' then
            display <= "0000000"; -- Display off on reset
        elsif rising_edge(clk) then
            if fan_signal = '1' then
                display <= "1111110"; -- Fan ON
            elsif light_signal = '1' then
                display <= "0111111"; -- Light ON
            else
                display <= "0000000"; -- Both OFF
            end if;
        end if;
    end process;

end Integrated;
