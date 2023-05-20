

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity testbench is
end testbench;
Architecture tb of testbench is
    component MUX is
        Port (
            mux_inp1_0,mux_inp1_1,mux_inp1_2,mux_inp1_3,mux_inp2_0,mux_inp2_1,mux_inp2_2,mux_inp2_3,mux_inp3_0,mux_inp3_1,mux_inp3_2,mux_inp3_3,mux_inp4_0,mux_inp4_1,mux_inp4_2,mux_inp4_3:in

  std_logic;--These are the 4 bit inputs to the mux
            mux_c0: in std_logic;--The selection bit0
            mux_c1: in std_logic;--The selection bit1
            mux_out_0,mux_out_1,mux_out_2,mux_out_3: out std_logic  );
    end component;
    signal
 mux_inp1_0,mux_inp1_1,mux_inp1_2,mux_inp1_3,mux_inp2_0,mux_inp2_1,mux_inp2_2,mux_inp2_3,mux_inp3_0,mux_inp3_1,mux_inp3_2,mux_inp3_3,mux_inp4_0,mux_inp4_1,mux_inp4_2,mux_inp4_3:

 std_logic;
    signal mux_c0: std_logic;--The selection bit0
    signal mux_c1: std_logic;
    signal mux_out_0,mux_out_1,mux_out_2,mux_out_3: std_logic;
begin
    UUT: MUX port map
(mux_inp1_0=>mux_inp1_0,mux_inp1_1=>mux_inp1_1,mux_inp1_2=>mux_inp1_2,mux_inp1_3=>mux_inp1_3,mux_inp2_0=>mux_inp2_0,mux_inp2_1=>mux_inp2_1,mux_inp2_2=>mux_inp2_2,mux_inp2_3=>mux_inp2_3,mux_inp3_0=>mux_inp3_0,mux_inp3_1=>mux_inp3_1,mux_inp3_2=>mux_inp3_2,mux_inp3_3=>mux_inp3_3,mux_inp4_0=>mux_inp4_0,mux_inp4_1=>mux_inp4_1,mux_inp4_2=>mux_inp4_2,mux_inp4_3=>mux_inp4_3,mux_c0=>mux_c0,mux_c1=>mux_c1,mux_out_0=>mux_out_0,mux_out_1=>mux_out_1,mux_out_2=>mux_out_2,mux_out_3=>mux_out_3);
    mux_inp1_0<='1';
    mux_inp1_1<='0';
    mux_inp1_2<='0';
    mux_inp1_3<='1';
    mux_inp2_0<='1';
    mux_inp2_1<='1';
    mux_inp2_2<='1';
    mux_inp2_3<='0';
    mux_inp3_0<='0';
    mux_inp3_1<='1';
    mux_inp3_2<='1';
    mux_inp3_3<='1';
    mux_inp4_0<='1';
    mux_inp4_1<='1';
    mux_inp4_2<='1';
    mux_inp4_3<='1';
    mux_c0<='0', '1' after 20 ns;
    mux_c1<='0','1' after 10 ns,'0' after 20 ns,'1' after 30 ns;
end tb;
