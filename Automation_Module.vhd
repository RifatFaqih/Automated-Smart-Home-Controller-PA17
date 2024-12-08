library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Automation_Module is
    Port ( clk        : in  STD_LOGIC;
           reset      : in  STD_LOGIC;
           temperature: in  STD_LOGIC_VECTOR(7 downto 0);
           fan_signal : out STD_LOGIC);
end Automation_Module;

architecture Behavioral of Automation_Module is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            fan_signal <= '0';
        elsif rising_edge(clk) then
            -- Loop construct to automate fan based on temperature
            if to_integer(unsigned(temperature)) > 25 then
                fan_signal <= '1'; -- Nyalakan kipas jika suhu lebih dari 25°C
            else
                fan_signal <= '0'; -- Matikan kipas jika suhu kurang dari 25°C
            end if;
        end if;
    end process;
end Behavioral;
