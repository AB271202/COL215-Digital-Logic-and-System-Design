library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity combine is
    port(clk: in std_logic;
         inp1,inp2,inp3,inp4: in std_logic_vector(3 downto 0);
         cat_out: out std_logic_vector(6 downto 0);
         an_out: out std_logic_vector(3 downto 0);
         dp: out std_logic);
end combine;

architecture Behavioral of combine is
    component decoder
        port(
            a: in std_logic;
            b: in std_logic;
            c: in std_logic;
            d: in std_logic;
            o1: out std_logic;
            o2: out std_logic;
            o3: out std_logic;
            o4: out std_logic;
            o5: out std_logic;
            o6: out std_logic;
            o7: out std_logic);
    end component;

    component MUX
        Port (mux_inp1_0,mux_inp1_1,mux_inp1_2,mux_inp1_3,mux_inp2_0,mux_inp2_1,mux_inp2_2,mux_inp2_3,mux_inp3_0,mux_inp3_1,mux_inp3_2,mux_inp3_3,mux_inp4_0,mux_inp4_1,mux_inp4_2,mux_inp4_3:in std_logic;--These are the 4 bit inputs to the mux
       mux_c0: in std_logic;--The selection bit0
       mux_c1: in std_logic;--The selection bit1
       mux_out_0,mux_out_1,mux_out_2,mux_out_3: out std_logic  );--The output
    end component;

    component timing
        Port(
            clk :in std_logic;
        to_mux_0:out std_logic;
        to_mux_1:out std_logic;
        Anode_out_0:out std_logic;
        Anode_out_1:out std_logic;
        Anode_out_2:out std_logic;
        Anode_out_3:out std_logic;
        dp:out std_logic);
    end component;
    --for all:decoder use work.decoder;
    --for all:MUX use work.MUX;
    --for all:timing use work.timing;
    signal tim_to_mux_0: std_logic;
    signal tim_to_mux_1: std_logic;
    --signal tim_to_mux_2: std_logic;
    --signal tim_to_mux_3: std_logic;
    signal outmux_0: std_logic;
    signal outmux_1: std_logic;
    signal outmux_2: std_logic;
     signal outmux_3: std_logic;


begin
  x2: timing port map(clk=>clk, to_mux_0=>tim_to_mux_0,to_mux_1=>tim_to_mux_1, Anode_out_0 => an_out(0), Anode_out_1 => an_out(1), Anode_out_2 => an_out(2), Anode_out_3 => an_out(3), dp=>dp);
  x3:decoder port map(a=>outmux_0,b=>outmux_1,c=>outmux_2,d=>outmux_3,o1=>cat_out(0),o2=>cat_out(1),o3=>cat_out(2),o4=>cat_out(3),o5=>cat_out(4),o6=>cat_out(5),o7=>cat_out(6));

  x1: MUX port map(mux_inp1_0=>inp1(3),mux_inp1_1=>inp1(2),mux_inp1_2=>inp1(1),mux_inp1_3=>inp1(0), mux_inp2_0=>inp2(3), mux_inp2_1=>inp2(2), mux_inp2_2=>inp2(1), mux_inp2_3=>inp2(0),mux_inp3_0=>inp3(3),mux_inp3_1=>inp3(2),mux_inp3_2=>inp3(1),mux_inp3_3=>inp3(0), mux_inp4_0=>inp4(3), mux_inp4_1=>inp4(2), mux_inp4_2=>inp4(1), mux_inp4_3=>inp4(0), mux_c0=>tim_to_mux_0,mux_c1=>tim_to_mux_1,mux_out_0=> outmux_0,mux_out_1=> outmux_1,mux_out_2=> outmux_2,mux_out_3=> outmux_3 );

end Behavioral;

