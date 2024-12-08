library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Display_System is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           fan_state : in  STD_LOGIC;
           light_state: in STD_LOGIC;
           display   : out STD_LOGIC_VECTOR(6 downto 0)); -- 7-segment output
end Display_System;

architecture Structural of Display_System is
    -- Deklarasi komponen decoder dan driver display
begin
    -- Logic untuk menampilkan status perangkat pada display
    process(clk, reset)
    begin
        if reset = '1' then
            display <= "0000000"; -- Display off pada reset
        elsif rising_edge(clk) then
            -- Menampilkan status perangkat (lampu dan kipas)
            if fan_state = '1' then
                display <= "1111110";  -- Menampilkan karakter kipas menyala
            elsif light_state = '1' then
                display <= "0111111";  -- Menampilkan karakter lampu menyala
            else
                display <= "0000000";  -- Display off jika keduanya mati
            end if;
        end if;
    end process;
end Structural;

