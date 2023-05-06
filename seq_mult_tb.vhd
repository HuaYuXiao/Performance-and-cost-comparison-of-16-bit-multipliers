library ieee;
use ieee.std_logic_1164.all;

entity seq_mult_tb is
end entity seq_mult_tb;

architecture tb of seq_mult_tb is
    signal CLK: std_logic := '1';
    signal RESET, start: std_logic := '0';
    signal a_in, b_in: std_logic_vector(15 downto 0):=(others=>'0');
--    signal ready: std_logic:='0';
    signal r: std_logic_vector(31 downto 0):=(others=>'0');
    
    component seq_mult
        port (CLK, RESET, start: in std_logic;
              a_in, b_in: in std_logic_vector(15 downto 0);
--              ready: out std_logic;
              r: out std_logic_vector(31 downto 0));
    end component;
begin
--    uut: seq_mult port map (CLK, RESET, start, a_in, b_in, ready, r);
    uut: seq_mult port map (CLK, RESET, start, a_in, b_in, r);
    
    -- clock generation
    CLK <= not CLK after 5 ns;
    
    -- stimulus
    stim_proc: process is
    begin
        RESET <= '1';
        wait for 10 ns;
        RESET <= '0'; 
        wait for 10 ns;               
        start <= '1';
        
        a_in <= x"0001";
        b_in <= x"0001";
        wait for 40 ns;
        
        a_in <= x"0002";
        b_in <= x"0002";
        wait for 40 ns;
        
        a_in <= x"0003";
        b_in <= x"0003";
        wait for 50 ns;

        a_in <= x"0004";
        b_in <= x"0004";
        wait for 60 ns;
        
        a_in <= x"0005";
        b_in <= x"0005";
        wait for 70 ns;
        
        a_in <= x"0006";
        b_in <= x"0006";
        wait for 80 ns;
        
                
        wait;
    end process stim_proc;
end architecture tb;