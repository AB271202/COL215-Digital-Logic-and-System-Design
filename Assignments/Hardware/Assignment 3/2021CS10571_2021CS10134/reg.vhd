-- Code your design here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY reg_8bit IS
    PORT (
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clk : IN STD_LOGIC;
        we : IN STD_LOGIC;
        re : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END reg_8bit;

ARCHITECTURE behavioral OF reg_8bit IS

    SIGNAL temp : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    PROCESS (clk) IS BEGIN
        IF rising_edge(clk) THEN

            IF re = '1' THEN
                temp <= din;
            END IF;

            IF we = '1' THEN
                dout <= temp;
            END IF;

        END IF;
    END PROCESS;

END behavioral;