LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY RAM IS
   PORT (
     a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
     d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
     clk : IN STD_LOGIC;
     we : IN STD_LOGIC;
     spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
   );
END RAM;

ARCHITECTURE Behavioral OF RAM IS
   COMPONENT dist_mem_gen_2
     PORT (
       a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
       d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
       clk : IN STD_LOGIC;
       we : IN STD_LOGIC;
       spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
     );
   END COMPONENT;

      

BEGIN
   
     uut : dist_mem_gen_2 port map (a=>a, d=>d,clk=>clk,we=>we,spo=>spo);

   
END Behavioral;
