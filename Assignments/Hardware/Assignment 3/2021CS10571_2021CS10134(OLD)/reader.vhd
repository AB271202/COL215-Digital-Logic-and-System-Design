LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY inp_out IS
    PORT (
        clk : IN STD_LOGIC;
        ssdinp : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END inp_out;

ARCHITECTURE behavioral OF inp_out IS
    COMPONENT combine
        PORT (
            clk : IN STD_LOGIC;
            inp1, inp2, inp3, inp4 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT RAM
        PORT (
            a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            we : IN STD_LOGIC;
            spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    SIGNAL d : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ram_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL a : std_logic_vector(13 downto 0);
BEGIN
    --This works!
    a <= ssdinp(13 downto 0);
    getdata : RAM PORT MAP(a => a, d => d, clk => clk, we => '0', spo => ram_out);
    senddata : combine PORT MAP(clk => clk, inp1 => ram_out(15 DOWNTO 12), inp2 => ram_out(11 DOWNTO 8), inp3 => ram_out(7 DOWNTO 4), inp4 => ram_out(3 DOWNTO 0), cat_out => cat_out, an_out => an_out);

END behavioral;