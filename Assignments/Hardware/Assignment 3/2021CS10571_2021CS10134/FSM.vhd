LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FSM IS
    PORT (
        clk : IN STD_LOGIC;
        ssdinp : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
        cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
       -- terminate3: out std_logic);
--        Address1s : OUT integer;
--        Address2s : OUT integer;
--        Address3s : OUT integer;
--        output1:out  integer
        --to_ram1 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
END FSM;
ARCHITECTURE finite OF FSM IS
    COMPONENT combine
        PORT (
            clk : IN STD_LOGIC;
            inp1, inp2, inp3, inp4 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            cat_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            an_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    COMPONENT Multiplier
        PORT (
        clk: in std_logic;
        counter: in integer;
            cntrl: in std_logic;
            bit1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            bit2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    COMPONENT RAM
        PORT (
            a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            we : IN STD_LOGIC;
            spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    COMPONENT ROM
        PORT (
            clk : IN STD_LOGIC;
            raddress1 : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            raddress2 : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            bit1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            bit2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));

    END COMPONENT;

    COMPONENT reg_8bit
        PORT (
            din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            clk : IN STD_LOGIC;
            we : IN STD_LOGIC;
            re : IN STD_LOGIC;
            dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;
    COMPONENT reg_16bit
        PORT (
            din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : IN STD_LOGIC;
            we : IN STD_LOGIC;
            re : IN STD_LOGIC;
            dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL counter : INTEGER := 1;
    SIGNAL cntrl : STD_LOGIC := '0';
    SIGNAL bit1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL bit2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL output : STD_LOGIC_VECTOR(15 DOWNTO 0);
    --signal Rom_output_1: std_logic_vector(7 downto 0);
    --signal Rom_output_2: std_logic_vector(7 downto 0);
    SIGNAL terminate : STD_LOGIC := '0';
    SIGNAL read_enable1 : STD_LOGIC := '0';
    SIGNAL write_enable1 : STD_LOGIC := '0';
    SIGNAL read_enable2 : STD_LOGIC := '0';
    SIGNAL write_enable2 : STD_LOGIC := '0';
    SIGNAL register1_signal : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL register2_signal : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL to_ram : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL spo : STD_LOGIC_VECTOR(15 DOWNTO 0);
     SIGNAL Address1sd : STD_LOGIC_VECTOR(13 DOWNTO 0):="00000000000000";
     SIGNAL Address2sd : STD_LOGIC_VECTOR(13 DOWNTO 0):="00000000000000";
     SIGNAL Address3sd : STD_LOGIC_VECTOR(13 DOWNTO 0):="00000000000000";
     signal test: std_logic_vector(3 downto 0):="0000";
    SIGNAL terminate2 : STD_LOGIC := '1';
    signal ram_out:std_logic_vector(15 downto 0);
    TYPE signal_type IS (A, B, C, D);
    SIGNAL state : signal_type := B;
BEGIN
    PROCESS (clk) IS
        VARIABLE Address1 : INTEGER := 0;
        VARIABLE Address2 : INTEGER := 0;
        VARIABLE Address_RAM : INTEGER := -1;
        variable counter3: integer :=0;
    BEGIN

        IF (rising_edge(clk)) THEN
            counter <= counter + 1;
--            Address1s<=Address1;
--            Address2s<=Address2;
--            Address3s<=Address_RAM;
            IF (terminate = '0') THEN
                CASE(state) IS

                    WHEN D =>
                    counter3:=counter3+1;
                    
                    IF (counter3=128) THEN
                        terminate <= '1';
                        terminate2 <= '0';
                        test<="1111";
                    END IF;
                    Address1 := 0;
                    Address2 := Address2 + 1;
                    Address_RAM := Address_RAM + 1;
                    state <= B;
                    cntrl <= '1';
                    read_enable2 <= '0';
                    write_enable2 <= '1';
                    
                    

                    WHEN C =>
                   
                    Address1 := Address1 - 16255;
                    Address2 := Address2 - 127;
                    Address_RAM := Address_RAM + 1;
                    state <= B;
                    cntrl <= '1';
                    read_enable2 <= '0';
                    write_enable2 <= '1';
                    

                    WHEN A =>
                    Address1 := Address1 + 128;
                    Address2 := Address2 + 1;
                    state <= B;
                    WHEN B =>
                    IF (counter MOD 4 = 2) THEN
--output1<=to_integer(unsigned(to_ram));
                        read_enable1 <= '1';
                        write_enable1 <= '0';
                        read_enable2 <= '0';
                        write_enable2 <= '1';
                        cntrl <= '0';
                        

                    ELSIF (counter MOD 4 = 0) THEN

                        IF (counter mod 65536 =0) THEN
                            state <= D;
                            --output1<=to_integer(unsigned(to_ram));
                            read_enable2 <= '1';
                            write_enable2 <= '0';

                        ELSIF (counter MOD 512 = 0) THEN
                            state <= C;
                           -- output1<=to_integer(unsigned(to_ram));
                            read_enable2 <= '1';
                            write_enable2 <= '0';

                        ELSE
                            state <= A;
                        END IF;
                        read_enable1 <= '0';
                        write_enable1 <= '1';
                    END IF;

                    WHEN OTHERS => state <= B;

                END CASE;
            END IF;

            Address1sd <= STD_LOGIC_VECTOR(to_unsigned(Address1, Address1sd'length));
            Address2sd <= STD_LOGIC_VECTOR(to_unsigned(Address2, Address2sd'length));
            Address3sd <= STD_LOGIC_VECTOR(to_unsigned(Address_RAM, 14));
            if (terminate='1') then
            Address3sd <=ssdinp;
            end if;
            
        END IF;
    END PROCESS;
    

    
    x1 : ROM PORT MAP(
        clk => clk, raddress1 => Address1sd, raddress2 => Address2sd, bit1 => bit1,
        bit2 => bit2);
    x4 : Multiplier PORT MAP(clk=>clk,counter=>counter,cntrl=>cntrl,bit1 => bit1, bit2 => bit2, output => output);
    x5 : reg_16bit PORT MAP(
        din => output, clk => clk,
        we => write_enable2, re => read_enable2, dout => to_ram);
    x6 : RAM PORT MAP(a => Address3sd, d => to_ram, clk => clk, we => terminate2, spo => ram_out);
       senddata : combine PORT MAP(clk => clk, inp4 => ram_out(15 DOWNTO 12), inp3 => ram_out(11 DOWNTO 8), inp2 => ram_out(7 DOWNTO 4), inp1 => ram_out(3 DOWNTO 0), cat_out => cat_out, an_out => an_out);
END finite;