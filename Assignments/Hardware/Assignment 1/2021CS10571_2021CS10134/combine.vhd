LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY combine IS
    PORT (
        clk : IN STD_LOGIC;
        inp1, inp2, inp3, inp4 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END combine;

ARCHITECTURE Behavioral OF combine IS
    COMPONENT decoder
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            c : IN STD_LOGIC;
            d : IN STD_LOGIC;
            o1 : OUT STD_LOGIC;
            o2 : OUT STD_LOGIC;
            o3 : OUT STD_LOGIC;
            o4 : OUT STD_LOGIC;
            o5 : OUT STD_LOGIC;
            o6 : OUT STD_LOGIC;
            o7 : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT MUX
        PORT (
            mux_inp1_0, mux_inp1_1, mux_inp1_2, mux_inp1_3, mux_inp2_0, mux_inp2_1, mux_inp2_2, mux_inp2_3, mux_inp3_0, mux_inp3_1, mux_inp3_2, mux_inp3_3, mux_inp4_0, mux_inp4_1, mux_inp4_2, mux_inp4_3 : IN STD_LOGIC;--These are the 4 bit inputs to the mux
            mux_c0 : IN STD_LOGIC;--The selection bit0
            mux_c1 : IN STD_LOGIC;--The selection bit1
            mux_out_0, mux_out_1, mux_out_2, mux_out_3 : OUT STD_LOGIC);--The output
    END COMPONENT;

    COMPONENT timing
        PORT (
            clk : IN STD_LOGIC;
            to_mux_0 : OUT STD_LOGIC;
            to_mux_1 : OUT STD_LOGIC;
            Anode_out_0 : OUT STD_LOGIC;
            Anode_out_1 : OUT STD_LOGIC;
            Anode_out_2 : OUT STD_LOGIC;
            Anode_out_3 : OUT STD_LOGIC);
    END COMPONENT;
    --for all:decoder use work.decoder;
    --for all:MUX use work.MUX;
    --for all:timing use work.timing;
    SIGNAL tim_to_mux_0 : STD_LOGIC;
    SIGNAL tim_to_mux_1 : STD_LOGIC;
    --signal tim_to_mux_2: std_logic;
    --signal tim_to_mux_3: std_logic;
    SIGNAL outmux_0 : STD_LOGIC;
    SIGNAL outmux_1 : STD_LOGIC;
    SIGNAL outmux_2 : STD_LOGIC;
    SIGNAL outmux_3 : STD_LOGIC;
BEGIN
    x2 : timing PORT MAP(clk => clk, to_mux_0 => tim_to_mux_0, to_mux_1 => tim_to_mux_1, Anode_out_0 => an_out(0), Anode_out_1 => an_out(1), Anode_out_2 => an_out(2), Anode_out_3 => an_out(3));
    x3 : decoder PORT MAP(a => outmux_0, b => outmux_1, c => outmux_2, d => outmux_3, o1 => cat_out(0), o2 => cat_out(1), o3 => cat_out(2), o4 => cat_out(3), o5 => cat_out(4), o6 => cat_out(5), o7 => cat_out(6));

    x1 : MUX PORT MAP(mux_inp1_0 => inp1(0), mux_inp1_1 => inp1(1), mux_inp1_2 => inp1(2), mux_inp1_3 => inp1(3), mux_inp2_0 => inp2(0), mux_inp2_1 => inp2(1), mux_inp2_2 => inp2(2), mux_inp2_3 => inp2(3), mux_inp3_0 => inp3(0), mux_inp3_1 => inp3(1), mux_inp3_2 => inp3(2), mux_inp3_3 => inp3(3), mux_inp4_0 => inp4(0), mux_inp4_1 => inp4(1), mux_inp4_2 => inp4(2), mux_inp4_3 => inp4(3), mux_c0 => tim_to_mux_0, mux_c1 => tim_to_mux_1, mux_out_0 => outmux_0, mux_out_1 => outmux_1, mux_out_2 => outmux_2, mux_out_3 => outmux_3);

END Behavioral;