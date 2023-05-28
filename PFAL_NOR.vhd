----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 03:14:31 PM
-- Design Name: 
-- Module Name: PFAL_NOR - Behavioral
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

entity PFAL_NOR is
    Port ( clk : in std_logic;
           phi : std_logic_vector(1 downto 0);
           A : in STD_LOGIC;
           Abar : in STD_LOGIC;
           B : in STD_LOGIC;
           Bbar : in STD_LOGIC;
           Out1 : out STD_LOGIC;
           Out1bar : out STD_LOGIC);
end PFAL_NOR;

architecture Behavioral of PFAL_NOR is

function isCharging (phi : std_logic_vector) return boolean is
begin
    -- Add the logic for determining if the input is charging
    return phi = "11";
end function isCharging;

signal Out1s : std_logic;
signal Out1bars : std_logic;

begin

process(clk)
begin
if(rising_edge(clk))then
   if((Abar = '1' or Bbar = '1' or Out1s = '0') and isCharging(phi))then
        Out1bars <= '1';
        
   elsif(Out1s = '1')then
        Out1bars <= '0';

   else
        Out1bars <= Out1bars;
   end if;
end if;

Out1bar <= Out1bars;
end process;

process(clk)
begin

if(rising_edge(clk))then
   if(((A = '1' and B = '1') or Out1bars = '0') and isCharging(phi))then
        Out1s <= '1';
        
   elsif(Out1bars = '1')then
        Out1s <= '0';

   else
        Out1s <= Out1s;
   end if;
end if;

Out1 <= Out1s;

end process;
end Behavioral;
