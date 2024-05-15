LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EightBitAdderSubtractor is 
    PORT
    (
        InputA, InputB  : IN STD_LOGIC_VECTOR(7 downto 0);
        Operation   :   IN STD_LOGIC;
        Result    :   OUT STD_LOGIC_VECTOR(7 downto 0);
        CarryOUT    :   OUT STD_LOGIC
    );
    END EightBitAdderSubtractor;

ARCHITECTURE rtl of EightBitAdderSubtractor is
    SIGNAL B_Feed, Opeartion_Vector  :   STD_LOGIC_VECTOR(7 downto 0);
    COMPONENT EightBitRippleAdder is
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            CarryIN         : IN STD_LOGIC;
            Sum             : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            CarryOUT        : OUT STD_LOGIC
        );
    END COMPONENT;
    BEGIN
    Opeartion_Vector <= (others => Operation);
    B_Feed <= InputB xor Opeartion_Vector;
        RA  :   EightBitRippleAdder
            PORT MAP
            (
                InputA => InputA,
                InputB => B_Feed,
                CarryIN => Operation,
                Sum => Result,
                CarryOUT => CarryOUT
            );
    END rtl;
