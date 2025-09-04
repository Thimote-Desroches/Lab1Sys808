LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY interfaceWithMemory_tb IS
END ENTITY interfaceWithMemory_tb;

ARCHITECTURE behavioral OF interfaceWithMemory_tb IS
    -- Component declaration for the Unit Under Test (UUT)
    COMPONENT interfaceWithMemory IS
        GENERIC (
            NumOfBit : INTEGER := 9;
            NumOfLine : INTEGER := 50
        );
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            enb : OUT STD_LOGIC;
            addrb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            dinb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            web : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            doutB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            mux_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            Data : IN STD_LOGIC_VECTOR(799 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT mockOfDelayLine IS
        GENERIC (
            numOfLine : INTEGER := 50; -- Number of delayLine encoder couple
            numOfBit : INTEGER := 9
        );
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            outData : OUT STD_LOGIC_VECTOR((numOfBit * numOfLine) - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT bit_string_formating
        GENERIC (
            numOfLine : INTEGER := 25; -- Number of delayLine encoder couple
            numOfBit : INTEGER := 9; -- Num of bit per delay line
            bit_string_length : INTEGER := 16 -- How long do we want the complet string of bit
        );

        PORT (
            string_of_bit : IN STD_LOGIC_VECTOR((numOfLine * numOfBit - 1) DOWNTO 0);

            outData : OUT STD_LOGIC_VECTOR((bit_string_length * numOfLine - 1) DOWNTO 0)
        );
    END COMPONENT;
    -- Signals to connect to the UUT
    SIGNAL tb_clk : STD_LOGIC := '0';
    SIGNAL tb_rst : STD_LOGIC := '1'; -- Initialize reset high
    SIGNAL tb_enable : STD_LOGIC := '0';
    SIGNAL tb_enb : STD_LOGIC := '1';
    SIGNAL tb_addrb : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL tb_dinb : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL tb_web : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL tb_doutB : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL tb_Data : STD_LOGIC_VECTOR(799 DOWNTO 0);
    SIGNAL delayLine_sig : STD_LOGIC_VECTOR(449 DOWNTO 0);
    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;

    COMPONENT slicer450To50 IS
        PORT (
            unSlicedString : IN STD_LOGIC_VECTOR(449 DOWNTO 0);
            sliced0 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced1 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced2 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced3 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced4 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced5 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced6 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced7 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced8 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced9 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced10 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced11 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced12 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced13 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced14 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced15 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced16 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced17 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced18 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced19 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced20 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced21 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced22 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced23 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced24 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced25 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced26 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced27 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced28 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced29 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced30 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced31 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced32 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced33 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced34 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced35 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced36 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced37 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced38 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced39 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced40 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced41 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced42 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced43 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced44 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced45 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced46 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced47 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced48 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            sliced49 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT slicer800To50
        PORT (
            unSlicedString : IN STD_LOGIC_VECTOR(799 DOWNTO 0);
            sliced0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced3 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced4 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced5 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced6 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced7 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced8 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced9 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced10 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced11 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced12 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced13 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced14 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced15 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced16 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced17 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced18 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced19 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced20 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced21 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced22 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced23 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced24 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced25 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced26 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced27 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced28 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced29 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced30 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced31 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced32 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced33 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced34 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced35 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced36 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced37 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced38 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced39 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced40 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced41 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced42 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced43 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced44 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced45 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced46 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced47 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced48 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            sliced49 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)

        );
    END COMPONENT;

    TYPE sig_array_t IS ARRAY (0 TO 49) OF STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL sig : sig_array_t;
    TYPE sig_array_16 IS ARRAY (0 TO 49) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL sig_16 : sig_array_16;
    SIGNAL tb_mux : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN
    slice : slicer450To50
    PORT MAP(
        unSlicedString => delayLine_sig,
        sliced0 => sig(0),
        sliced1 => sig(1),
        sliced2 => sig(2),
        sliced3 => sig(3),
        sliced4 => sig(4),
        sliced5 => sig(5),
        sliced6 => sig(6),
        sliced7 => sig(7),
        sliced8 => sig(8),
        sliced9 => sig(9),
        sliced10 => sig(10),
        sliced11 => sig(11),
        sliced12 => sig(12),
        sliced13 => sig(13),
        sliced14 => sig(14),
        sliced15 => sig(15),
        sliced16 => sig(16),
        sliced17 => sig(17),
        sliced18 => sig(18),
        sliced19 => sig(19),
        sliced20 => sig(20),
        sliced21 => sig(21),
        sliced22 => sig(22),
        sliced23 => sig(23),
        sliced24 => sig(24),
        sliced25 => sig(25),
        sliced26 => sig(26),
        sliced27 => sig(27),
        sliced28 => sig(28),
        sliced29 => sig(29),
        sliced30 => sig(30),
        sliced31 => sig(31),
        sliced32 => sig(32),
        sliced33 => sig(33),
        sliced34 => sig(34),
        sliced35 => sig(35),
        sliced36 => sig(36),
        sliced37 => sig(37),
        sliced38 => sig(38),
        sliced39 => sig(39),
        sliced40 => sig(40),
        sliced41 => sig(41),
        sliced42 => sig(42),
        sliced43 => sig(43),
        sliced44 => sig(44),
        sliced45 => sig(45),
        sliced46 => sig(46),
        sliced47 => sig(47),
        sliced48 => sig(48),
        sliced49 => sig(49)
    );
    sliceAfter : slicer800To50
    PORT MAP(
        unSlicedString => tb_Data,
        sliced0 => sig_16(0),
        sliced1 => sig_16(1),
        sliced2 => sig_16(2),
        sliced3 => sig_16(3),
        sliced4 => sig_16(4),
        sliced5 => sig_16(5),
        sliced6 => sig_16(6),
        sliced7 => sig_16(7),
        sliced8 => sig_16(8),
        sliced9 => sig_16(9),
        sliced10 => sig_16(10),
        sliced11 => sig_16(11),
        sliced12 => sig_16(12),
        sliced13 => sig_16(13),
        sliced14 => sig_16(14),
        sliced15 => sig_16(15),
        sliced16 => sig_16(16),
        sliced17 => sig_16(17),
        sliced18 => sig_16(18),
        sliced19 => sig_16(19),
        sliced20 => sig_16(20),
        sliced21 => sig_16(21),
        sliced22 => sig_16(22),
        sliced23 => sig_16(23),
        sliced24 => sig_16(24),
        sliced25 => sig_16(25),
        sliced26 => sig_16(26),
        sliced27 => sig_16(27),
        sliced28 => sig_16(28),
        sliced29 => sig_16(29),
        sliced30 => sig_16(30),
        sliced31 => sig_16(31),
        sliced32 => sig_16(32),
        sliced33 => sig_16(33),
        sliced34 => sig_16(34),
        sliced35 => sig_16(35),
        sliced36 => sig_16(36),
        sliced37 => sig_16(37),
        sliced38 => sig_16(38),
        sliced39 => sig_16(39),
        sliced40 => sig_16(40),
        sliced41 => sig_16(41),
        sliced42 => sig_16(42),
        sliced43 => sig_16(43),
        sliced44 => sig_16(44),
        sliced45 => sig_16(45),
        sliced46 => sig_16(46),
        sliced47 => sig_16(47),
        sliced48 => sig_16(48),
        sliced49 => sig_16(49)
    );

    delay : mockOfDelayLine
    GENERIC MAP(
        numOfLine => 50,
        numOfBit => 9)
    PORT MAP(
        clk => tb_clk,
        reset => tb_rst,
        outData => delayLine_sig
    );
    format : bit_string_formating
    GENERIC MAP(
        numOfLine => 50,
        numOfBit => 9,
        bit_string_length => 16)
    PORT MAP(
        string_of_bit => delayLine_sig,
        outData => tb_Data
    );

    interface : interfaceWithMemory
    GENERIC MAP(
        NumOfBit => 9, -- Width of the input and output vectors
        NumOfLine => 50

    )
    PORT MAP(
        clk => tb_clk,
        rst => tb_rst,
        enable => tb_enable,
        enb => tb_enb,
        addrb => tb_addrb,
        dinb => tb_dinb,
        web => tb_web,
        doutB => tb_doutB,
        mux_out => tb_mux,
        Data => tb_Data
    );
    -- Clock process definitions
    clock_process : PROCESS
    BEGIN
        tb_clk <= '0';
        WAIT FOR clk_period;
        tb_clk <= '1';
        WAIT FOR clk_period;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        -- hold reset state for 100 ns.
        tb_rst <= '1';
        WAIT FOR 20 ns;
        tb_rst <= '0';
        WAIT FOR 100ns;
        tb_enable <= '0';
        WAIT FOR 150ns;
        tb_enable <= '1';
        WAIT;
    END PROCESS;
END behavioral;