LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY inp_out_tb IS
END inp_out_tb;

ARCHITECTURE behavioral OF inp_out_tb IS
    COMPONENT inp_out
    PORT (
        clk : IN STD_LOGIC;
        ssdinp : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    SIGNAL clk : std_logic:='0';
    SIGNAL ssdinp : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL cat_out : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL an_out : std_logic_vector(3 downto 0);
BEGIN
   clk<= not clk after 5 ns;
   ssdinp<="0000000000000001" after 50 ns;
   uut: inp_out port map (clk=>clk, ssdinp=>ssdinp,cat_out=>cat_out, an_out=>an_out);
END behavioral;