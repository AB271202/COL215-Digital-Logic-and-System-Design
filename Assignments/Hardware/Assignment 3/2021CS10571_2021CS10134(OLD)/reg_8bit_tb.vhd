-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_tb is 
end reg_tb;

architecture behavioral of reg_tb is 
component reg_8bit 
port(din: in std_logic_vector(7 downto 0);
clk: in std_logic;
we: in std_logic;
re: in std_logic;
dout: out std_logic_vector(7 downto 0));
end component;
signal din: std_logic_vector(7 downto 0);
signal clk: std_logic :='0';
signal we: std_logic;
signal re: std_logic;
signal dout: std_logic_vector(7 downto 0);
signal tem :integer:=0;

begin

process (clk) is
begin
if (tem<1000000) then
clk<=not clk after 5 ns;
tem<=tem+1;
end if;
end process;

din <= "00001010", "00101000" after 30 ns, "00001011" after 60 ns, "00101010" after 90 ns;

re <= '1' after 12 ns;
we <= '1' after 24 ns;
uut: reg_8bit port map(din=>din, clk=>clk, we=>we,re=>re,dout=>dout);

end behavioral;