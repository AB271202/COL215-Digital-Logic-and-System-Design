library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
Port ( mux_inp1_0,mux_inp1_1,mux_inp1_2,mux_inp1_3,mux_inp2_0,mux_inp2_1,mux_inp2_2,mux_inp2_3,mux_inp3_0,mux_inp3_1,mux_inp3_2,mux_inp3_3,mux_inp4_0,mux_inp4_1,mux_inp4_2,mux_inp4_3:in std_logic;--These are the 4 bit inputs to the mux
       mux_c0: in std_logic;--The selection bit0
       mux_c1: in std_logic;--The selection bit1
       mux_out_0,mux_out_1,mux_out_2,mux_out_3: out std_logic  );--The output
end MUX;

architecture Behavioral of MUX is

begin
process (mux_c0, mux_c1) is
begin

if mux_c0='0' then

              if (mux_c1='0') then
mux_out_0<=mux_inp1_0;
mux_out_1<=mux_inp1_1;
mux_out_2<=mux_inp1_2;
mux_out_3<=mux_inp1_3;

              elsif (mux_c1='1') then
mux_out_0<=mux_inp2_0;
mux_out_1<=mux_inp2_1;
mux_out_2<=mux_inp2_2;
mux_out_3<=mux_inp2_3;
              end if;
elsif mux_c0 = '1' then

              if mux_c1='0' then
mux_out_0<=mux_inp3_0;
mux_out_1<=mux_inp3_1;
mux_out_2<=mux_inp3_2;
mux_out_3<=mux_inp3_3;

              elsif mux_c1='1' then
mux_out_0<=mux_inp4_0;
mux_out_1<=mux_inp4_1;
mux_out_2<=mux_inp4_2;
mux_out_3<=mux_inp4_3;
end if ;

end if;
 end process;
end Behavioral;