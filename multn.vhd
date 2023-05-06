library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity mult5 is
port (clk, reset : in std_logic;
a, b : in std_logic_vector(4 downto 0);
y: out std_logic_vector(9 downto 0));
end entity mult5;


architecture efficient_pipe_arch of mult5 is

constant WIDTH : integer := 5;
signal a2_reg, a3_reg, a4_reg: std_logic_vector(WIDTH-1 downto 0);
signal a1, a2_next, a3_next, a4_next:std_logic_vector(WIDTH-1 downto 0);
signal b1: std_logic_vector(4 downto 1);
signal b2_next, b2_reg: std_logic_vector (4 downto 2);
signal b3_next, b3_reg: std_logic_vector (4 downto 3);
signal b4_next, b4_reg: std_logic_vector (4 downto 4);
signal bv0, bv1, bv2, bv3, bv4:std_logic_vector (4 downto 0);
signal bp0, bp1, bp2, bp3, bp4:std_logic_vector (5 downto 0);
signal pp0: std_logic_vector (5 downto 0);
signal pp1_next, pp1_reg:std_logic_vector (6 downto 0);
signal pp2_next, pp2_reg: std_logic_vector (7 downto 0);
signal pp3_next, pp3_reg: std_logic_vector (8 downto 0);
signal pp4_next, pp4_reg: std_logic_vector (9 downto 0);

begin
-- pipeline registers
process (clk, reset)
begin
if (reset = '1') then
    pp1_reg <= (others => '0');
    pp2_reg <= (others => '0');
    pp3_reg <= (others => '0');
    pp4_reg <= (others => '0');
    a2_reg <= (others => '0');
    a3_reg <= (others => '0');
    a4_reg <= (others => '0');
    b2_reg <= (others => '0');
    b3_reg <= (others => '0');
    b4_reg <= (others => '0');
elsif (clk'event and clk = '1') then
    pp1_reg <= pp1_next;
    pp2_reg <= pp2_next;
    pp3_reg <= pp3_next;
    pp4_reg <= pp4_next;
    a2_reg <= a2_next;
    a3_reg <= a3_next;
    a4_reg <= a4_next;
    b2_reg <= b2_next;
    b3_reg <= b3_next;
    b4_reg <= b4_next;
end if;
end process;

-- stage 0
bv0 <= (others => b(0));
bp0 <= "0" & (bv0 and a);
pp0 <= bp0;
a1 <= a;
b1 <= b (4 downto 1);
-- stage 1
bv1 <= (others => b1(1));
bp1 <= "0" & (bv1 and a1);
pp1_next(6 downto 1) <= ("0" & pp0(5 downto 1)) + bp1;
pp1_next(0) <= pp0(0);
a2_next <= a1;
b2_next <= b1(4 downto 2);
-- stage 2
bv2 <= (others => b2_reg(2));
bp2 <= "0" & (bv2 and a2_reg);
pp2_next(7 downto 2) <= ("0" & pp1_reg(6 downto 2)) + bp2;
pp2_next(1 downto 0) <= pp1_reg(1 downto 0);
a3_next <= a2_reg;
b3_next <= b2_reg(4 downto 3);
-- stage 3
bv3 <= (others => b3_reg(3));
bp3 <= "0" & (bv3 and a3_reg);
pp3_next(8 downto 3) <=
("0" & pp2_reg(7 downto 3)) + bp3;
pp3_next(2 downto 0) <= pp2_reg(2 downto 0);
a4_next <= a3_reg;
b4_next <= b3_reg(4 downto 4);
-- stage 4
bv4 <= (others => b4_reg(4));
bp4 <= "0" & (bv4 and a4_reg);
pp4_next(9 downto 4) <=
("0" & pp3_reg(8 downto 4)) + bp4;
pp4_next(3 downto 0) <= pp3_reg(3 downto 0);
-- output
y <= pp4_reg;

end architecture efficient_pipe_arch;