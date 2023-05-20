LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY testbench IS
END testbench;
ARCHITECTURE Test_FSM of testbench IS
    COMPONENT FSM IS
    PORT (
        clk : IN STD_LOGIC;
        Address1s : OUT integer;
        Address2s : OUT integer;
        Address3s : OUT integer
        --to_ram1 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );

    END COMPONENT;
    signal to_ram : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL Address1sd :  integer;
        SIGNAL Address2sd :  integer;
        SIGNAL Address3sd :  integer;
    SIGNAL clk : STD_LOGIC := '0';
BEGIN
    uut : FSM PORT MAP(clk => clk, Address1s => Address1sd,Address2s => Address2sd,Address3s => Address3sd);
    clk <= NOT clk AFTER 5 ns;
END Test_FSM;