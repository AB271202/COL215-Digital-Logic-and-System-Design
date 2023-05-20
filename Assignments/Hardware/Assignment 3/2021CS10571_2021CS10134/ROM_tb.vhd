LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity my_ROM_tb IS
end my_ROM_tb;

architecture ROM_behavioral of my_ROM_tb IS
COMPONENT ROM is
Port(clk: in std_logic;
raddress1: in std_logic_vector(13 downto 0);
raddress2: in std_logic_vector(13 downto 0);
bit1: out std_logic_vector(7 downto 0);
bit2: out std_logic_vector(7 downto 0));
end component;
signal bit1,bit2 : std_logic_vector(7 downto 0);
signal raddress1,raddress2: std_logic_vector(13 downto 0);
signal clk: std_logic:='0';
BEGIN
clk<=not clk after 5 ns;
raddress1<="00000000000000", "00000000000001" after 40 ns, "00000000000010" after 80 ns;
raddress2<="00000000000000", "00000010000000" after 40 ns, "00000100000000" after 80 ns;
 
uut: ROM port map(clk=>clk, raddress1=>raddress1, raddress2=>raddress2, bit1=>bit1, bit2=>bit2);

end ROM_behavioral;