-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAC_tb is 
end MAC_tb;

architecture behavioral of MAC_tb is 
component multiplier 
port(--clk:in std_logic;
cntrl: in std_logic;
output: out std_logic_vector (15 downto 0);
bit1: in std_logic_vector (7 downto 0);
bit2: in std_logic_vector (7 downto 0));
end component;
signal cntrl: std_logic :='0';
signal output: std_logic_vector (15 downto 0);
signal bit1: std_logic_vector (7 downto 0);
signal bit2: std_logic_vector (7 downto 0);
--signal tem :integer:=0;

begin

-- process (clk) is
-- begin
-- if (tem<1000000) then
-- clk<=not clk after 5 ns;
-- tem<=tem+1;
-- end if;
-- end process;

cntrl<= '1' after 5 ns, '0' after 10 ns, '1' after 100 ns;

bit1<=std_logic_vector(to_unsigned(5,bit1'length)),std_logic_vector(to_unsigned(6,bit1'length)) after 30 ns, std_logic_vector(to_unsigned(7,bit1'length)) after 60 ns, std_logic_vector(to_unsigned(1,bit1'length)) after 90 ns ; 

bit2<=std_logic_vector(to_unsigned(3,bit1'length)),std_logic_vector(to_unsigned(4,bit1'length)) after 30 ns, std_logic_vector(to_unsigned(5,bit1'length)) after 60 ns, std_logic_vector(to_unsigned(2,bit1'length)) after 90 ns ; 
uut: multiplier port map (clk=>clk, cntrl=>cntrl, output=>output, bit1=>bit1, bit2=>bit2);

end behavioral;