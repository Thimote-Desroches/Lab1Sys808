--Author Thimote Desroches
--Date: 2025-04-28
--Simple testbench for generic DFF
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_DFF_Vector IS

END ENTITY tb_DFF_Vector;

ARCHITECTURE behavior OF tb_DFF_Vector IS

    -- Constants
    CONSTANT N : INTEGER := 8;

    -- Signals to connect to the DFF
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL D : STD_LOGIC_VECTOR(N - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Q : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL QN : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : ENTITY work.DFF_Vector
        GENERIC MAP(N => N)
        PORT MAP(
            clk => clk,
            reset => reset,
            D => D,
            Q => Q,
            QN => QN
        );

    -- Clock generation
    clk_process : PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR 5 ns;
            clk <= '1';
            WAIT FOR 5 ns;
        END LOOP;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Initialize
        reset <= '1';
        D <= (OTHERS => '0');
        WAIT FOR 20 ns;

        reset <= '0';
        WAIT FOR 10 ns;

        -- Apply some inputs
        D <= "10101010";
        WAIT FOR 10 ns; -- Wait 1 clock cycle

        D <= "01010101";
        WAIT FOR 10 ns;

        D <= "11110000";
        WAIT FOR 10 ns;

        D <= "00001111";
        WAIT FOR 10 ns;

        -- Test reset again
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';
        WAIT FOR 10 ns;

        -- End simulation
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;