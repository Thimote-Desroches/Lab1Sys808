LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
--Date: 2025-04-28
--Simple generic counter
--Author fpga4student.com - Modified by Thimote to make it generic

ENTITY UP_COUNTER IS
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
END UP_COUNTER;

ARCHITECTURE Behavioral OF UP_COUNTER IS
    SIGNAL counter_up : INTEGER := 0;
BEGIN
    -- up counter
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (reset = '1') THEN
                counter_up <= startOfCounter;
            ELSE
                IF counter_up >= endCount THEN
                    counter_up <= startOfCounter;
                ELSE
                    counter_up <= counter_up + increment;
                END IF;

            END IF;
        END IF;
    END PROCESS;
    counter <= STD_LOGIC_VECTOR(to_unsigned(counter_up, N));

END Behavioral;