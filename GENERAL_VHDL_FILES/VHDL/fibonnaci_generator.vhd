----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Thimoté Desroches
-- 
-- Create Date: 09/04/2025 12:15:27 PM
-- Design Name: 
-- Module Name: fibonnaci_generator - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity fibonnaci_generator is
    Port ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           N        : in  STD_LOGIC_VECTOR(3 downto 0);
           I        : out STD_LOGIC_VECTOR(3 downto 0);
           FibSeq   : out STD_LOGIC_VECTOR(8 downto 0)
           );          
end fibonnaci_generator;

architecture Behavioral of fibonnaci_generator is
 
    signal I_reg        : unsigned(3 downto 0) := (others => '0');
    signal FibSeq_reg   : unsigned(8 downto 0) := (others => '0');
    signal prev1, prev2 : unsigned(8 downto 0) := (others => '0');
      
BEGIN
   
     PROCESS(clk) 
        BEGIN
        if rising_edge(clk) then
            if reset = '1' then
                -- Reset state
                I_reg      <= (others => '0');
                FibSeq_reg <= (others => '0');
                prev1      <= (others => '0');
                prev2      <= (others => '0');
            else
                if I_reg = 0 then
                    FibSeq_reg <= to_unsigned(1, FibSeq_reg'length);
                    prev1      <= to_unsigned(1, prev1'length);
                    prev2      <= to_unsigned(0, prev2'length);
                    I_reg <= I_reg + 1;
                elsif I_reg < unsigned(N) - 1 then
                    FibSeq_reg <= prev1 + prev2;
                    prev2      <= prev1;
                    prev1      <= prev1 + prev2;
                    I_reg <= I_reg + 1;
                else
                    FibSeq_reg <= to_unsigned(0, FibSeq_reg'length);
                    I_reg <= (others => '0');
                end if;
            end if;
        end if;
    END PROCESS;
    
    I      <= std_logic_vector(I_reg);
    FibSeq <= std_logic_vector(FibSeq_reg);
    
end Behavioral;
