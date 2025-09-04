--Author Thimote Desroches
--Date: 2025-04-28
--Simple generic DFF
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DFF_Vector IS
    GENERIC (
        N : INTEGER := 8 -- Width of the input and output vectors
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        QN : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END ENTITY DFF_Vector;

ARCHITECTURE Behavioral OF DFF_Vector IS
    SIGNAL Q_reg : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
BEGIN

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            Q_reg <= (OTHERS => '0'); -- Reset to 0
        ELSIF rising_edge(clk) THEN
            Q_reg <= D;
        END IF;
    END PROCESS;

    Q <= Q_reg;
    QN <= NOT Q_reg; -- Inverted output

END ARCHITECTURE Behavioral;