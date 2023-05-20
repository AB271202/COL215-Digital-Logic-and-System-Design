LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FSM IS
    PORT (
        clk : IN STD_LOGIC;
        Address1s : OUT integer;
        Address2s : OUT integer;
        Address3s : OUT integer
        --to_ram1 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );

END FSM;
ARCHITECTURE finite OF FSM IS

    COMPONENT Multiplier
        PORT (
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
     SIGNAL Address1sd : STD_LOGIC_VECTOR(13 DOWNTO 0);
     SIGNAL Address2sd : STD_LOGIC_VECTOR(13 DOWNTO 0);
     SIGNAL Address3sd : STD_LOGIC_VECTOR(13 DOWNTO 0);
    SIGNAL terminate2 : STD_LOGIC := '1';

    TYPE signal_type IS (A, B, C, D);
    SIGNAL state : signal_type := B;
BEGIN
    PROCESS (clk) IS
        VARIABLE Address1 : INTEGER := 0;
        VARIABLE Address2 : INTEGER := 0;
        VARIABLE Address_RAM : INTEGER := 0;
    BEGIN

        IF (rising_edge(clk)) THEN
            counter <= counter + 1;
            Address1s<=Address1;
            Address2s<=Address2;
            Address3s<=Address_RAM;

            IF (terminate = '0') THEN
                CASE(state) IS

                    WHEN D =>
                    counter <= 1;
                    IF (Address1 = 16383 AND Address2 = 16383) THEN
                        terminate <= '1';
                        terminate2 <= '0';
                    END IF;
                    Address1 := 0;
                    Address2 := Address2 + 1;
                    Address_RAM := Address_RAM + 1;
                    state <= B;
                    cntrl <= '1';
                    read_enable2 <= '1';
                    write_enable2 <= '0';
                    Address_RAM := Address_RAM + 1;

                    WHEN C =>
                    read_enable2 <= '1';
                    write_enable2 <= '0';
                    Address1 := Address1 - 16255;
                    Address2 := Address2 - 128;
                    Address_RAM := Address_RAM + 1;
                    state <= B;
                    cntrl <= '1';
                    read_enable2 <= '1';
                    write_enable2 <= '0';
                    Address_RAM := Address_RAM + 1;

                    WHEN A =>
                    Address1 := Address1 + 128;
                    Address2 := Address2 + 1;
                    state <= B;
                    WHEN B =>
                    IF (counter MOD 4 = 1) THEN
                        read_enable1 <= '1';
                        write_enable1 <= '0';
                        read_enable2 <= '0';
                        write_enable2 <= '1';
                        cntrl <= '0';

                    ELSIF (counter MOD 4 = 0) THEN

                        IF (counter = 65536) THEN
                            state <= D;
                        ELSIF (counter MOD 512 = 0) THEN
                            state <= C;
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
            Address3sd <= STD_LOGIC_VECTOR(to_unsigned(Address_RAM, 1));
        END IF;
    END PROCESS;
    x1 : ROM PORT MAP(
        clk => clk, raddress1 => Address1sd, raddress2 => Address2sd, bit1 => register1_signal,
        bit2 => register2_signal);
    x2 : reg_8bit PORT MAP(
        din => register1_signal, clk => clk,
        we => write_enable1, re => read_enable1, dout => bit1);
    x3 : reg_8bit PORT MAP(
        din => register2_signal, clk => clk,
        we => write_enable1, re => read_enable1, dout => bit2);
    x4 : Multiplier PORT MAP(cntrl=>cntrl,bit1 => bit1, bit2 => bit2, output => output);
    x5 : reg_16bit PORT MAP(
        din => output, clk => clk,
        we => write_enable2, re => read_enable2, dout => to_ram);
    x6 : RAM PORT MAP(a => Address3sd, d => to_ram, clk => clk, we => terminate2, spo => spo);
END finite;