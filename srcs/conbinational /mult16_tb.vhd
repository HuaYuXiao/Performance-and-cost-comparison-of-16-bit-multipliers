library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mult16_tb is
end entity mult16_tb;


architecture tb of mult16_tb is
    signal a, b : std_logic_vector(15 downto 0);
    signal y: std_logic_vector(31 downto 0);
begin
    uut: entity work.mult16
        port map(
            a => a,
            b => b,
            y => y
        );

    stimulus: process
    begin
        a <=x"0001";
        b <=x"0001";
        wait for 10 ns;
        
        a <= std_logic_vector(to_unsigned(2, 16));
        b <= std_logic_vector(to_unsigned(2, 16));
        wait for 10 ns;
        
        a <= std_logic_vector(to_unsigned(3, 16));
        b <= std_logic_vector(to_unsigned(3, 16));
        wait for 10 ns;
        
        wait;
    end process stimulus;
end architecture tb;
