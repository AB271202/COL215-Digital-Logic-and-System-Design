library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
end testbench;
architecture tb of testbench is
component timing is
Port(
         clk :in std_logic;
         to_mux_0:out std_logic;
         to_mux_1:out std_logic;
         Anode_out_0:out std_logic;
         Anode_out_1:out std_logic;
         Anode_out_2:out std_logic;
         Anode_out_3:out std_logic);
    end component;
signal clk :std_logic;
signal to_mux_0: std_logic;
signal to_mux_1: std_logic;
signal Anode_out_0: std_logic;
signal Anode_out_1: std_logic;
signal Anode_out_2: std_logic;
signal Anode_out_3: std_logic;

begin
UUT: timing port map 
(clk=>clk,to_mux_0=>to_mux_0,to_mux_1=>to_mux_1,Anode_out_0=>Anode_out_0,Anode_out_1=>Anode_out_1,Anode_out_2=>Anode_out_2,Anode_out_3=>Anode_out_3);
clk<='0','1' after 10 ns,'0' after 20 ns,'1' after 30 ns,'0' after 40 
ns,'1' after 50 ns, '0' after 60 ns,'1' after 70 ns, '0' after 80 ns, 
'1' after 90 ns, '0' after 100 ns,'1' after 110 ns,'0' after 120 ns,'1' 
after 130 ns,'0' after 140 ns,'1' after 150 ns, '0' after 160 ns,'1' 
after 170 ns, '0' after 180 ns, '1' after 190 ns;
end tb;