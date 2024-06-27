LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY SignExtend16To32BitModule IS 
    PORT 
    (
        i_OPERAND       : IN STD_LOGIC_VECTOR(15 downto 0);
        o_OUTPUT        : OUT STD_LOGIC_VECTOR(31 downto 0)
    );
END SignExtend16To32BitModule;

ARCHITECTURE RTL OF SignExtend16To32BitModule IS
    
BEGIN

    o_OUTPUT <= (31 downto 16 => i_OPERAND(15)) & i_OPERAND;
    
END RTL;
