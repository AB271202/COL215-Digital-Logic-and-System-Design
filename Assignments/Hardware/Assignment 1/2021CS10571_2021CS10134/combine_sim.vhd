library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity testbench is
end testbench;
architecture tb of testbench is
component combine is
Port(clk: in std_logic;
         inp1,inp2,inp3,inp4: in std_logic_vector(3 downto 0);
         cat_out: out std_logic_vector(6 downto 0);
         an_out: out std_logic_vector(3 downto 0));
            end component;
         signal clk: std_logic:='0';
         signal inp1: std_logic_vector(3 downto 0);
         signal inp2: std_logic_vector(3 downto 0);
         signal inp3: std_logic_vector(3 downto 0);
         signal inp4: std_logic_vector(3 downto 0);
         signal cat_out: std_logic_vector(6 downto 0);
         signal an_out: std_logic_vector(3 downto 0);
         signal tem: integer:=0;
         begin
         UUT: combine port map(clk=>clk,inp1=>inp1,inp2=>inp2,inp3=>inp3,inp4=>inp4,cat_out=>cat_out,an_out=>an_out);
process (clk) is
begin
if (tem<1000000) then
clk<=not clk after 10 ps;
tem<=tem+1;
end if;
inp1<="1001";
inp2<="1100";
inp3<="1110";
inp4<="1010";
end process;
end tb;