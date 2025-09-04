----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/24/2025 11:18:50 AM
-- Design Name: 
-- Module Name: OR - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OR_gateRTL is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           outPutOrGate : out STD_LOGIC);
end OR_gateRTL;

architecture Behavioral of OR_gateRTL is

begin

outPutOrGate <= a or b;


end Behavioral;
