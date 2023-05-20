----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2022 11:23:18 AM
-- Design Name: 
-- Module Name: decoder_sim - Behavioral
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

entity decoder_sim is
--  Port ( );
end decoder_sim;

architecture Behavioral of decoder_sim is
    component decoder
    port(a,b,c,d: in std_logic;
        o1,o2,o3,o4,o5,o6,o7:out std_logic);
    end component;
    signal a,b,c,d,o1,o2,o3,o4,o5,o6,o7: std_logic;
begin
UUT : decoder port map(a => a, b => b, c => c, d =>d, o1 => o1, o2 => o2,o3 => o3,o4 => o4,o5 => o5,o6 => o6, o7 => o7);
-- inputs
-- 00 at 0 ns
-- 01 at 20 ns, as b is 0 at 20 ns and a is changed to 1 at 20 ns
-- 10 at 40 ns
-- 11 at 60 ns
a <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
b <= '0', '1' after 40 ns;
c <= '0', '1' after 40 ns;
d <= '0', '1' after 40 ns;
end Behavioral;
