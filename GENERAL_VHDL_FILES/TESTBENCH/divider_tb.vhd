LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_clk_divider IS
END tb_clk_divider;

ARCHITECTURE Behavioral OF tb_clk_divider IS

    -- Component declaration
    COMPONENT clk_divider IS
        GENERIC (
            DIVISOR : INTEGER := 3
        );
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Signals
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL clk_out : STD_LOGIC;
    SIGNAL clk_out2 : STD_LOGIC;

    SIGNAL clk_out3 : STD_LOGIC;
    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN

    -- Clock generation
    clk_process : PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR CLK_PERIOD / 2;
            clk <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
    END PROCESS;

    -- Reset pulse
    reset_process : PROCESS
    BEGIN
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT;
    END PROCESS;

    -- Instantiate the Unit Under Test (UUT)
    uut : clk_divider
    GENERIC MAP(
        DIVISOR => 3 -- or any power of 2 if needed
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        clk_out => clk_out
    );
    uut2 : clk_divider
    GENERIC MAP(
        DIVISOR => 2 -- or any power of 2 if needed
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        clk_out => clk_out2
    );

    uut3 : clk_divider
    GENERIC MAP(
        DIVISOR => 4 -- or any power of 2 if needed
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        clk_out => clk_out3
    );
END Behavioral;