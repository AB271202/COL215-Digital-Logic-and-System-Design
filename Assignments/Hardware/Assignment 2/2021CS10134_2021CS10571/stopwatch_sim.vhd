  library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stopwatch_sim is
end stopwatch_sim;

architecture Behavioral of stopwatch_sim is
component stopwatch is
Port(
clk:in std_logic;
reset:in std_logic;
start:in std_logic;
pause: in std_logic;
continue:in std_logic;
cat_out: out std_logic_vector(6 downto 0);
an_out: out std_logic_vector(3 downto 0);
dp:out std_logic);
end component;

signal clk :std_logic :='0';
signal reset:std_logic;
signal start:std_logic;
signal pause:std_logic;
signal continue:std_logic;
signal cat_out: std_logic_vector(6 downto 0);
signal an_out: std_logic_vector(3 downto 0);
signal dp:std_logic;
signal tem :integer:=0;

begin

UUT: stopwatch port 
map(clk=>clk,start=>start, pause=>pause,continue=>continue,reset=>reset,cat_out=>cat_out,an_out=>an_out, dp=>dp);

process (clk) is
begin
--if (tem<1000000) then
clk<=not clk after 1 ns;
--tem<=tem+1;
--end if;
end process;

reset<='0', '1' after 800 ns;
start<='0', '1' after 5 ns;--'1' after 1000 ns,'0' after 3000 ns,'1' after 4000 ns;
pause<='0', '1' after 50 ns;
continue<='0', '1' after 300 ns;

end Behavioral;