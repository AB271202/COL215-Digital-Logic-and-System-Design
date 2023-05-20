-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAC_tb is 
end MAC_tb;

architecture behavioral of MAC_tb is 
component multiplier 
port(clk:in std_logic;
counter: in integer;
cntrl: in std_logic;
output: out std_logic_vector (15 downto 0);
bit1: in std_logic_vector (7 downto 0);
bit2: in std_logic_vector (7 downto 0));
end component;
signal cntrl: std_logic :='1';
signal output: std_logic_vector (15 downto 0);
signal bit1: std_logic_vector (7 downto 0) := (others => '0');
signal bit2: std_logic_vector (7 downto 0) := (others => '0');
signal clk:  std_logic:='0';
signal counter: integer:=1;
--signal tem :integer:=0;

begin

-- process (clk) is
-- begin
-- if (tem<1000000) then
clk<=not clk after 5 ns;
-- tem<=tem+1;
-- end if;
-- end process;
process (clk) is
begin
if rising_edge(clk) then
counter<=counter+1;
end if;
end process;
cntrl<= '0', '1' after 120 ns, '0' after 130 ns;

bit1 <= "00000111" after 40 ns, "00000010" after 80 ns, "00000001" after 120ns;
bit2 <= "00000011" after 40 ns, "00000111" after 80 ns, "00000011" after 120ns;

--bit1<=std_logic_vector(to_unsigned(5,bit1'length)),std_logic_vector(to_unsigned(6,bit1'length)) after 30 ns, std_logic_vector(to_unsigned(7,bit1'length)) after 60 ns, std_logic_vector(to_unsigned(1,bit1'length)) after 90 ns ; 

--bit2<=std_logic_vector(to_unsigned(3,bit2'length)),std_logic_vector(to_unsigned(4,bit2'length)) after 30 ns, std_logic_vector(to_unsigned(5,bit2'length)) after 60 ns, std_logic_vector(to_unsigned(2,bit2'length)) after 90 ns ;
 
uut: multiplier port map ( clk=>clk, counter=> counter,cntrl=>cntrl, output=>output, bit1=>bit1,bit2=>bit2);

end behavioral;