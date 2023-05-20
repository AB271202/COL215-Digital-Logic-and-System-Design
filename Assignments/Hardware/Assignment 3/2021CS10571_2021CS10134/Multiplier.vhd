library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;
use ieee.Numeric_std.all;
entity multiplier is
port(clk:in std_logic;
cntrl: in std_logic;
output: out std_logic_vector (15 downto 0);
bit1: in std_logic_vector (7 downto 0);
bit2: in std_logic_vector (7 downto 0));
end multiplier;
Architecture arc of multiplier is
signal accumulator:std_logic_vector(15 downto 0):="0000000000000000";
begin
output <= accumulator;
process(clk,cntrl) is
begin
if (cntrl='1'and cntrl'event) then
accumulator<= "0000000000000000";
end if;
if (rising_edge(clk)) then
accumulator<=std_logic_vector(unsigned(accumulator)+(unsigned(bit1)*unsigned(bit2)));
end if;
end process;
end arc;