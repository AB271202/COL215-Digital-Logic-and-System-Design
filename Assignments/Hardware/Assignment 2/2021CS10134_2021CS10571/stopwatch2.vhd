-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- my_slv <= std_logic_vector(to_unsigned(my_int, my_slv'length));

entity stopwatch is
port( clk:in std_logic;
      start: in std_logic;
       pause:in std_logic;
       continue: in std_logic;
       reset: in std_logic;
        --clk: in std_logic;
     an_out: out std_logic_vector(3 downto 0);
     cat_out: out std_logic_vector(6 downto 0);
     dp:out std_logic);
end stopwatch;

architecture stopwatch_logic of stopwatch is
signal counter1: integer :=0;
-- signal counter3: integer :=0;
-- signal counter4: integer :=0;
signal counter2: integer :=0;
-- signal counter5: integer :=0;

signal enable_watch: std_logic :='0';
signal reset_watch: std_logic :='0';
signal min,sect,seco,msec: std_logic_vector(3 downto 0);


component combine is
     port(clk: in std_logic;
          inp1,inp2,inp3,inp4: in std_logic_vector(3 downto 0);
          cat_out: out std_logic_vector(6 downto 0);
          an_out: out std_logic_vector(3 downto 0);
          dp:out std_logic);
end component;

begin
process (clk) is
begin
if rising_edge(clk)  then
   if (reset_watch='0'and enable_watch ='1') then
     if counter1<10000000 then --CHANGE
       counter1<=counter1+1;
     elsif counter1=10000000 then --CHANGE
       counter1<=0;
     end if;
   elsif reset_watch='1' then counter1<=0;
   end if;
end if;
end process;

--enable_watch<=(start and (not pause) and (not continue)) or (start and pause and continue);
--reset_watch<=reset;
process (clk) is
begin
if (rising_edge(clk)) then
if ( start='1') then enable_watch<='1';
end if;
if ( pause='1') then enable_watch<='0';
end if;
if ( continue='1') then enable_watch<='1';
end if;
end if;
end process;

process (clk) is
begin
if (rising_edge(clk)) then
if reset='1'  then reset_watch<='1';
else reset_watch<='0';
end if;
end if;
end process;

process (counter1, reset_watch) is
begin
	if reset_watch = '1' then counter2<=0;
   else
		if counter1= 10000000  then --CHANGE
			counter2<=counter2+1;
		end if;
		if counter2=6000 then 
   		counter2<=0;
		end if;
	end if;
end process;

-- process (clk) is
-- begin
-- if rising_edge(clk)  then
--       if counter1<10000000 then --CHANGE
--         counter1<=counter1+1;
--       elsif counter1=10000000 then --CHANGE
--         counter1<=0;
--       end if;
    
-- end if;
-- end process;
-- process (counter1) is
-- begin
-- --	if reset_watch = '1' then counter2<=0;
-- --    else
         
-- 		if counter1= 10000000 then --CHANGE
-- 			counter2<=counter2+1;
-- 		end if;
-- 		if counter2=6000 then 
--     		counter2<=0;
-- 		end if;
-- --		if(counter2 mod 10=0) then
-- --		counter3<=counter3+1;
-- --		end if;
-- --		if (counter2 mod 100 =0) then
-- --		counter4<=counter4+1;
-- --		end if;
-- --		if (counter2 mod 600 =0) then
-- --		counter5<=counter5+1;
-- --		end if;
		
-- --	end if;
-- end process;

min<=std_logic_vector(to_unsigned(integer(counter2/600), min'length));
sect<=std_logic_vector(to_unsigned(integer((counter2 mod 600)/100),sect'length));
seco<=std_logic_vector(to_unsigned(integer(counter2/10) mod 10,seco'length));
msec<=std_logic_vector(to_unsigned(counter2 mod 10, msec'length));

--min<=std_logic_vector(to_unsigned(counter5 mod 10, min'length));
--sect<=std_logic_vector(to_unsigned(counter4 mod 6,
--sect'length));
--seco<=std_logic_vector(to_unsigned(counter3 mod 10,
--seco'length));
--msec<=std_logic_vector(to_unsigned(counter2 mod 10, msec'length));

x: combine port map (clk=>clk, inp1=>msec, inp2=>seco, inp3=>sect,
inp4=>min,cat_out=>cat_out, an_out=>an_out, dp=>dp);

end stopwatch_logic;
