----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 11:37:25 AM
-- Design Name: 
-- Module Name: interfaceWithMemory - Behavioral
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY interfaceWithMemory IS
    GENERIC (
        NumOfBit : INTEGER := 9; -- Width of the input and output vectors
        NumOfLine : INTEGER := 50

    );
    PORT (
        clk : IN STD_LOGIC; --good
        rst : IN STD_LOGIC; --good
        enable : IN STD_LOGIC;
        enb : OUT STD_LOGIC;
        addrb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- good
        dinb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --good
        web : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        doutB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        mux_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        Data : IN STD_LOGIC_VECTOR(NumOfLine * NumOfBit - 1 DOWNTO 0)

    );
END interfaceWithMemory;

ARCHITECTURE Behavioral OF interfaceWithMemory IS
    CONSTANT N : INTEGER := 16;
    COMPONENT UP_COUNTER
        GENERIC (
            N : INTEGER := 8; -- Width of the input and output vectors
            startOfCounter : INTEGER := 0;
            increment : INTEGER := 1;
            endCount : INTEGER := 100
        );
        PORT (
            clk : IN STD_LOGIC; -- clock input
            reset : IN STD_LOGIC; -- reset input 
            counter : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0) -- output 4-bit counter
        );
    END COMPONENT;
    SIGNAL counterAddr : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    CONSTANT baseAddr : STD_LOGIC_VECTOR(N - 1 DOWNTO 0) := x"A000"; --TODO make this an argument 
    SIGNAL mux : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL clk_sig : STD_LOGIC;
BEGIN
    clk_sig <= clk AND enable;
    addr : UP_COUNTER
    GENERIC MAP(
        N => 16,
        startOfCounter => 0,
        increment => 4,
        endCount => 65535)
    PORT MAP(
        clk => clk_sig,
        reset => '0',
        counter => counterAddr);

    counter_line : UP_COUNTER
    GENERIC MAP(
        N => 5,
        startOfCounter => 0,
        increment => 1,
        endCount => NumOfLine/2 - 1)
    PORT MAP(
        clk => clk_sig,
        reset => '0',
        counter => mux);

    addrb <= baseAddr & counterAddr;
    PROCESS (enable)
    BEGIN
        IF (enable = '1') THEN
            web <= "1111";
        ELSE
            web <= "0000";
        END IF;
    END PROCESS;
    enb <= enable;
    PROCESS (mux, Data)
        VARIABLE index_start : INTEGER;
    BEGIN
        -- Convert the std_logic_vector to a natural number
        index_start := TO_INTEGER(unsigned(mux)) * 32;
        IF index_start < Data'length THEN
            dinb <= Data(index_start + 31 DOWNTO index_start);
        ELSE
            -- Handle out-of-bounds counter value
            dinb <= (OTHERS => '0');
        END IF;
    END PROCESS;
    mux_out <= mux;

END Behavioral;