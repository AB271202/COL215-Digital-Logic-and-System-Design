----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2022 11:06:00 AM
-- Design Name: 
-- Module Name: decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
port(
a: in std_logic;
b: in std_logic;
c: in std_logic;
d: in std_logic;
o1: out std_logic;
o2: out std_logic;
o3: out std_logic;
o4: out std_logic;
o5: out std_logic;
o6: out std_logic;
o7: out std_logic);
end decoder;

architecture Behavioral of decoder is


begin
o1 <= (a and ( not b) and c and d) or (a and b and ( not c) and d) or (( not a) and ( not b) and ( not c) and d) or (( not a) and b and ( not c) and ( not d));
o2 <= (( not a) and b and ( not c) and d) or (a and c and d) or (a and b and ( not d)) or (b and c and ( not d));
o3 <= (( not a) and ( not b) and c and ( not d)) or (a and b and ( not d)) or (a and b and c);
o4 <= (( not a) and ( not b) and ( not c) and d) or (( not a) and b and ( not c) and ( not d)) or (b and c and d);
o5 <= (( not a) and b and ( not c)) or (( not b) and ( not c) and d) or (( not a) and d);
o6 <= (a and b and ( not c) and d) or (( not a) and c and d) or (( not b) and c and ( not d)) or (( not a) and ( not b) and d);
o7 <= (a and b and ( not c) and ( not d)) or (( not a) and b and c and d) or (( not a) and ( not b) and ( not c));

end Behavioral;
