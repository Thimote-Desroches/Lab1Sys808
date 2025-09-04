----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 03:51:14 PM
-- Design Name: 
-- Module Name: clk_divider - Behavioral
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY clk_divider IS
    GENERIC (
        DIVISOR : INTEGER := 3 -- Power of 2
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC
    );
END clk_divider;

ARCHITECTURE Behavioral OF clk_divider IS
    COMPONENT DFF_Vector IS
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

    END COMPONENT;
    SIGNAL clk_intermediary_input : STD_LOGIC_VECTOR(DIVISOR - 1 DOWNTO 0);
    SIGNAL clk_intermediary_out : STD_LOGIC_VECTOR(DIVISOR - 1 DOWNTO 0);
BEGIN

    mainG : FOR I IN 0 TO DIVISOR - 1 GENERATE
        first : IF I = 0 GENERATE
            divider : DFF_Vector
            GENERIC MAP(
                N => 1
            )
            PORT MAP(
                clk => clk,
                reset => reset,
                D => clk_intermediary_input(I DOWNTO I),
                Q => clk_intermediary_out(I DOWNTO I),
                QN => clk_intermediary_input(I DOWNTO I)
            );
        END GENERATE;
        othersDff : IF I /= 0 GENERATE
            divider2 : DFF_Vector
            GENERIC MAP(
                N => 1
            )
            PORT MAP(
                clk => clk_intermediary_out(I - 1),
                reset => reset,
                D => clk_intermediary_input(I DOWNTO I),
                Q => clk_intermediary_out(I DOWNTO I),
                QN => clk_intermediary_input(I DOWNTO I)
            );

        END GENERATE;
    END GENERATE;
    clk_out <= clk_intermediary_out(DIVISOR - 1);
END Behavioral;