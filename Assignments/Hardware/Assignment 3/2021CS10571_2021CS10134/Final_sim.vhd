LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY final_sim IS
END final_sim;

ARCHITECTURE sim OF final_sim IS

    COMPONENT FSM
        PORT (
            clk : IN STD_LOGIC;
            ssdinp : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL cat_out : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL an_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ssdinp : std_logic_vector(13 DOWNTO 0);
BEGIN
    clk <= NOT clk AFTER 10 ns;
    ssdinp <= "00000000000000";
    uut : FSM PORT MAP(clk => clk, ssdinp => ssdinp, cat_out => cat_out, an_out => an_out);
END sim;