library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Environment_Monitoring_Module is
    Port ( temperature   : in  STD_LOGIC_VECTOR(7 downto 0);
           light_sensor  : in  STD_LOGIC_VECTOR(7 downto 0);
           fan_signal    : out STD_LOGIC;
           light_signal  : out STD_LOGIC);
end Environment_Monitoring_Module;

architecture Dataflow of Environment_Monitoring_Module is
begin
    -- Generate control signals based on sensor values
    fan_signal <= '1' when (to_integer(unsigned(temperature)) > 30) else '0';
    light_signal <= '1' when (to_integer(unsigned(light_sensor)) < 50) else '0';
end Dataflow;
