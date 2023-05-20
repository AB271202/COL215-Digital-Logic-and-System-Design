----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date: 10/19/2022 01:25:03 PM
-- Design Name:
-- Module Name: timing - Behavioral
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
entity timing is
    Port(
        clk :in std_logic;
        to_mux_0:out std_logic ;
        to_mux_1:out std_logic ;
        Anode_out_0:out std_logic ;
        Anode_out_1:out std_logic ;
        Anode_out_2:out std_logic ;
        Anode_out_3:out std_logic ;
        dp:out std_logic );
end timing;

architecture Behavioral of timing is

    signal tempvar1: std_logic ;
    signal tempvar2: std_logic ;
    signal counter : integer :=0 ;

begin
    process(clk) is

    begin
       if (rising_edge(clk)) then
            if counter<40000 then --CHANGE
                counter<=counter+1;
            elsif counter=40000 then--CHANGE
                counter<=0;
            end if;
        end if;
    end process;

    process(counter)  is

    begin

        if counter=20000 then
            if tempvar1='0' then
                tempvar1<='1';
            else
                tempvar1<='0';
            end if;
        elsif counter=40000 then
            if tempvar1='0' then
                tempvar1<='1';
            else
                tempvar1<='0';
            end if;
            if tempvar2='0' then
                tempvar2<='1';
            else
                tempvar2<='0';
            end if;

            -- if clk='1' then
            --     if tempvar='0' then
            --         tempvar<='1';
            --     else
            --         tempvar<='0';
            --     end if;
        end if;
    end process;
    process(tempvar1, tempvar2) is begin
        if (tempvar1='1' and tempvar2='1') then
            to_mux_0<='0';
            to_mux_1<='0';

            Anode_out_0<='0';
            Anode_out_1<='1';
            Anode_out_2<='1';
            Anode_out_3<='1';
            
            dp<='1';

        elsif (tempvar1='1' and tempvar2='0') then

            to_mux_0<='0';
            to_mux_1<='1';

            Anode_out_0<='1';
            Anode_out_1<='0';
            Anode_out_2<='1';
            Anode_out_3<='1';
            dp<='0';

        elsif (tempvar1='0' and tempvar2='1') then

            to_mux_0<='1';
            to_mux_1<='0';

            Anode_out_0<='1';
            Anode_out_1<='1';
            Anode_out_2<='0';
            Anode_out_3<='1';
            dp<='1';


        elsif (tempvar1='0' and tempvar2='0') then

            to_mux_0<='1';
            to_mux_1<='1';

            Anode_out_0<='1';
            Anode_out_1<='1';
            Anode_out_2<='1';
            Anode_out_3<='0';
            
            dp<='0';

        end if;

    end process;
end Behavioral;