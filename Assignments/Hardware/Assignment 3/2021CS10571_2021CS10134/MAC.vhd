library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.Numeric_std.all;


entity multiplier is
port(clk: in std_logic;
counter: in integer;
cntrl: in std_logic;
output: out std_logic_vector (15 downto 0);
bit1: in std_logic_vector (7 downto 0);
bit2: in std_logic_vector (7 downto 0));
end multiplier;


Architecture arc of multiplier is

    signal accumulator:std_logic_vector(15 downto 0):=(others=>'0');
        --signal counter : integer := 0;
    begin
            
        -- process (clk) is
        -- begin
        -- if rising_edge(clk) then
        --         if counter<2 then counter<=counter+1;
        --     elsif counter=2 then counter<=0;
        --     end if;
        -- end if;
        -- end process;
        
        
        output <= accumulator;
        process (clk) is
        begin
        if rising_edge(clk) then
        if (cntrl='1') then
            accumulator<= "0000000000000000";
        end if;
if (counter mod 4)=0 then
            accumulator<=std_logic_vector(unsigned(accumulator)+(unsigned(bit1)*unsigned(bit2)));
end if;
end if;
            end process;
end arc;