LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY ROM IS
Port(clk: in std_logic;
raddress1: in std_logic_vector(13 downto 0);
raddress2: in std_logic_vector(13 downto 0);
bit1: out std_logic_vector(7 downto 0);
bit2: out std_logic_vector(7 downto 0));
END ROM;

ARCHITECTURE behavior OF ROM IS
--ROM1
COMPONENT dist_mem_gen_0
PORT(
clk : IN STD_LOGIC;
a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

--ROM2
COMPONENT dist_mem_gen_1
PORT(
clk : IN STD_LOGIC;
a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;



BEGIN
-- Read image in VHDL
uut1: dist_mem_gen_0 PORT MAP (
clk => clk,
spo => bit1,
a => raddress1
);
uut2: dist_mem_gen_1 PORT MAP (
clk => clk,
spo => bit2,
a => raddress2
);


END;