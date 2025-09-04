----------------------------------------------------------------------------------
-- Testbench for the original fibonnaci_generator (Counter)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fibonacci_generator_tb is
end fibonacci_generator_tb;

architecture Behavioral of fibonacci_generator_tb is

    -- Component declaration for the Device Under Test (DUT)
    component fibonnaci_generator is
        Port ( clk       : in  STD_LOGIC;
               reset     : in  STD_LOGIC;
               N         : in  STD_LOGIC_VECTOR(3 downto 0);
               I         : out STD_LOGIC_VECTOR(3 downto 0);
               FibSeq    : out STD_LOGIC_VECTOR(8 downto 0)
             );
    end component;

    -- Signal declarations to connect to the DUT
    signal clk_tb      : STD_LOGIC := '0';
    signal reset_tb    : STD_LOGIC := '0';
    signal N_tb        : STD_LOGIC_VECTOR(3 downto 0);
    signal I_tb        : STD_LOGIC_VECTOR(3 downto 0);
    signal FibSeq_tb   : STD_LOGIC_VECTOR(8 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: fibonnaci_generator port map (
        clk    => clk_tb,
        reset  => reset_tb,
        N      => N_tb,
        I      => I_tb,
        FibSeq => FibSeq_tb
    );

    -- Clock process definition
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_process: process
    begin
        -- Initial reset (active low)
        reset_tb <= '1';
        wait for clk_period*4;
        reset_tb <= '0';
        N_tb <= "0101";  -- N = 5
        wait for clk_period * 13;
        reset_tb <= '1';
        
        -- Let the counter run. It should count from 0 to 4 and then reset to 0.
        -- Expected sequence of I: 0 -> 1 -> 2 -> 3 -> 4 -> 0 -> 1...
        wait for clk_period * 10;
        reset_tb <= '0';
        -- Change N and see how the counter behavior changes
        N_tb <= "0011"; -- N = 3
        
        -- The counter should now count from 0 to 2 and then reset to 0.
        -- Expected sequence of I: ... -> 4 -> 0 -> 1 -> 2 -> 0 -> 1...
        wait for clk_period * 10;
        
        -- Apply another reset
        reset_tb <= '0';
        wait for clk_period * 2;
        reset_tb <= '1';
        wait for clk_period * 2; 
        
        reset_tb <= '0';
        N_tb <= "1111";  -- N = 5
        wait for clk_period * 25;
        
        
        reset_tb <= '0';
        N_tb <= "0010";  -- N = 5
        wait for clk_period * 4;
        
        
        reset_tb <= '0';
        N_tb <= "1111";  -- N = 5
        wait for clk_period * 9;
        reset_tb <= '1';
        wait for clk_period * 2;
        reset_tb <= '0';
                    
        wait; -- Wait forever to end simulation
    end process;
end Behavioral;
