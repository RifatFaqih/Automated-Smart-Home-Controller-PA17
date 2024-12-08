library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity Device_Control_Module is
    Port ( clk           : in  STD_LOGIC;
           reset         : in  STD_LOGIC;
           temperature   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Suhu (8-bit)
           light_sensor  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Sensor Cahaya (8-bit)
           fan_control   : out STD_LOGIC;
           light_control : out STD_LOGIC;
           alarm_control : out STD_LOGIC);
end Device_Control_Module;

architecture Behavioral of Device_Control_Module is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            fan_control <= '0';
            light_control <= '0';
            alarm_control <= '0';
        elsif rising_edge(clk) then
            -- Fan control based on temperature
            if to_integer(unsigned(temperature)) > 30 then
                fan_control <= '1'; -- Nyalakan kipas jika suhu lebih dari 30�C
            else
                fan_control <= '0'; -- Matikan kipas jika suhu kurang dari 30�C
            end if;

            -- Light control based on light sensor
            if to_integer(unsigned(light_sensor)) < 50 then
                light_control <= '1'; -- Nyalakan lampu jika cahaya kurang dari ambang
            else
                light_control <= '0'; -- Matikan lampu jika cahaya cukup
            end if;

            -- Alarm control based on certain conditions (for example, temperature threshold)
            if to_integer(unsigned(temperature)) > 40 then
                alarm_control <= '1'; -- Nyalakan alarm jika suhu lebih dari 40�C
            else
                alarm_control <= '0'; -- Matikan alarm jika suhu kurang dari 40�C
            end if;
        end if;
    end process;
end Behavioral;