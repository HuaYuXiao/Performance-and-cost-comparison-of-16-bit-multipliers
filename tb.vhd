library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mult16_tb is
end entity mult16_tb;


architecture tb of mult16_tb is

    signal CLK: std_logic := '1';
    signal RESET: std_logic := '0';
    signal a, b : std_logic_vector(4 downto 0):="00000";
    signal y: std_logic_vector(9 downto 0):="0000000000";
    
    component mult5
        port (CLK, RESET: in std_logic;
              a, b: in std_logic_vector(4 downto 0);
              y: out std_logic_vector(9 downto 0));
    end component;
    
begin
    uut: mult5 port map (CLK, RESET, a, b, y);
    
    -- clock generation
    CLK <= not CLK after 5 ns;
    
    -- stimulus
    stimulus: process is
    begin
        RESET <= '1';
        wait for 10 ns;
        RESET <= '0';
        
        a <="00001";
        b <="00001";
        wait for 100 ns;
        
        a <= std_logic_vector(to_unsigned(2, 5));
        b <= std_logic_vector(to_unsigned(2, 5));
        wait for 100 ns;
        
        a <= std_logic_vector(to_unsigned(3, 5));
        b <= std_logic_vector(to_unsigned(3, 5));
        wait for 100 ns;
        
        wait;
    end process stimulus;
end architecture tb;