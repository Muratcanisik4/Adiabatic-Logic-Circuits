----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2023 07:10:51 PM
-- Design Name: 
-- Module Name: ECRL_NAND - Behavioral
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

entity ECRL_NAND is
    Port ( clk : in std_logic;
           A : in STD_LOGIC;
           Abar : in STD_LOGIC;
           B : in STD_LOGIC;
           Bbar : in STD_LOGIC;
           phi : in std_logic_vector(1 downto 0);
           Out1 : out STD_LOGIC;
           Out1bar : out STD_LOGIC);
end ECRL_NAND;

architecture Behavioral of ECRL_NAND is

signal Out1s, Out1bars : std_logic;

function isCharging(p: std_logic_vector) return boolean is
begin
    return p = "11";
end function isCharging;

begin

process(clk)
begin
if(rising_edge(clk))then
   if(A = '1' and B = '1')then
    Out1s <= '0';
   else
    if(Out1bars = '0') then
        if (isCharging(phi)) then
            Out1s <= '1';
        else
            Out1s <= '0';
        end if;
    else
        Out1s <= Out1s;
    end if;
   end if;
end if;

    Out1 <= Out1s;
end process;

process(clk)
begin

if(rising_edge(clk))then
   if(Abar = '1' or Bbar = '1')then
    Out1bars <= '0';
   else
    if(Out1s = '0')then
        if(isCharging(phi))then
            Out1bars <= '1';
        else
            Out1bars <= '0';
        end if;
    else
        Out1bars <= Out1bars;
    end if;
   end if;
end if;

Out1bar <= Out1bars;
end process;

end Behavioral;
