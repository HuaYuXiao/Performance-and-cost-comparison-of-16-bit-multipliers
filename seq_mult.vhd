library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity seq_mult is
port (CLK, RESET, start: in std_logic;
a_in, b_in: in std_logic_vector(15 downto 0);
r: out std_logic_vector(31 downto 0));
end entity seq_mult;


architecture seg_arch of seq_mult is

constant WIDTH : integer :=16;
type state_type is (idle, ab0, load, op);
signal state_reg, state_next : state_type;
signal a_reg, a_next, n_reg, n_next : std_logic_vector (WIDTH-1 downto 0);
signal r_reg, r_next : std_logic_vector (2*WIDTH-1 downto 0);

begin
-- state and data registers
process (CLK, RESET) is
begin
    if RESET = '1' then
        state_reg <= idle;
        a_reg <=x"0000";
        n_reg <=x"0000";
        r_reg <=(others=>'0');
    elsif CLK'event and CLK='1' then
        state_reg <= state_next;
        a_reg <= a_next;
        n_reg <= n_next;
        r_reg <= r_next;
    end if;
end process;

-- combinational circuit
process (start, state_reg, a_reg, n_reg, r_reg, a_in, b_in) is
begin
    -- default value
    a_next <= a_reg;
    n_next <= n_reg;
    r_next <= r_reg;
    case state_reg is
        when idle =>
            if start = '1' then
                if (a_in = x"0000" or b_in = x"0000") then
                    state_next <= ab0;
                else
                    state_next <= load;
                end if;
            else
                state_next <= idle;
            end if;
        when ab0 =>
            a_next <= a_in;
            n_next <= b_in;
            r_next <=(others=>'0');
            state_next <= idle;
        when load =>
            a_next <= a_in;
            n_next <= b_in;
            r_next <=(others=>'0');
            state_next <= op;
        when op =>    
            n_next <= n_reg - 1;
            r_next <= (x"0000" & a_reg)+ r_reg;
            if (n_reg =x"0001") then
                state_next <= idle;
            else
                state_next <= op;
            end if;
    end case;
end process;

r <= r_reg;

end architecture seg_arch;