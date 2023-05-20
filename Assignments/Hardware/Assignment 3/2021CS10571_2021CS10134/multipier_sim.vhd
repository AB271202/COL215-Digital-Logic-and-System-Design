
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity multiplier_testbench is
end multiplier_testbench;
architecture test of multiplier_testbench is
component multiplier is
port(clk:in std_logic;
cntrl: in std_logic;
output: out std_logic_vector (15 downto 0);
bit1: in std_logic_vector (7 downto 0);
bit2: in std_logic_vector (7 downto 0));
end component;
signal clk:std_logic:='0';
signal bit1:std_logic_vector(7 downto 0);
signal bit2:std_logic_vector(7 downto 0);
signal cntrl:std_logic;
signal output:std_logic_vector(15 downto 0);
signal tem:integer:=0;
begin
UUT: multiplier port
map(clk=>clk,cntrl=>cntrl,output=>output,bit1=>bit1,bit2=>bit2);
process (clk) is
begin
if (tem<1000000) then
clk<=not clk after 10 ns;
tem<=tem+1;
end if;

cntrl<='0';
bit1<="00001001";
bit2<="00001010";
end process;
end test;

