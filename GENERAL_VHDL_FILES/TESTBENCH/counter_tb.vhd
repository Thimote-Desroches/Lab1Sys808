LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--Date: 2025-04-28
--Simple generic counter
--Author fpga4student.com - Modified by Thimote to make it generic
ENTITY tb_counters IS
END tb_counters;

ARCHITECTURE Behavioral OF tb_counters IS

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
     SIGNAL reset, clk : STD_LOGIC;
     SIGNAL counter : STD_LOGIC_VECTOR(15 DOWNTO 0);
     SIGNAL counter2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
     dut : UP_COUNTER
     GENERIC MAP(
          N => 16,
          startOfCounter => 0,
          increment => 1,
          endCount => 65535)
     PORT MAP(
          clk => clk,
          reset => reset,
          counter => counter);
     dut2 : UP_COUNTER
     GENERIC MAP(
          N => 6,
          startOfCounter => 0,
          increment => 1,
          endCount => 25)
     PORT MAP(
          clk => clk,
          reset => reset,
          counter => counter2);
     -- Clock process definitions
     clock_process : PROCESS
     BEGIN
          clk <= '0';
          WAIT FOR 1 ns;
          clk <= '1';
          WAIT FOR 1 ns;
     END PROCESS;
     -- Stimulus process
     stim_proc : PROCESS
     BEGIN
          -- hold reset state for 100 ns.
          reset <= '1';
          WAIT FOR 20 ns;
          reset <= '0';
          WAIT FOR 100ns;

          reset <= '1';
          WAIT FOR 50 ns;
          reset <= '0';
          WAIT FOR 100 ns;
          reset <= '1';
          WAIT FOR 100 ns;
          reset <= '0';
          WAIT;
     END PROCESS;
END Behavioral;