LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AdderSubtractor is 
    PORT
    (
        InputA, InputB  : IN STD_LOGIC_VECTOR(3 downto 0);
        Operation   :   IN STD_LOGIC;
        Result    :   OUT STD_LOGIC_VECTOR(3 downto 0);
        CarryOUT    :   OUT STD_LOGIC
    );
    END AdderSubtractor;

ARCHITECTURE rtl of AdderSubtractor is
    SIGNAL B_Feed, Opeartion_Vector  :   STD_LOGIC_VECTOR(3 downto 0);
    COMPONENT RippleAdder is
        PORT
        (
            InputA, InputB  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            CarryIN         : IN STD_LOGIC;
            Sum             : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            CarryOUT        : OUT STD_LOGIC
        );
    END COMPONENT;
    BEGIN
    Opeartion_Vector <= (others => Operation);
    B_Feed <= InputB xor Opeartion_Vector;
        RA  :   RippleAdder
            PORT MAP
            (
                InputA => InputA,
                InputB => B_Feed,
                CarryIN => Operation,
                Sum => Result,
                CarryOUT => CarryOUT
            );
    END rtl;
