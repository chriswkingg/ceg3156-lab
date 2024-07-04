LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY HazardDetectionUnit is
    PORT
    (
        ID_EX_MemRead        : IN STD_LOGIC;
        ID_EX_RegisterRt     : IN STD_LOGIC_VECTOR(2 downto 0);
        IF_ID_RegisterRs     : IN STD_LOGIC_VECTOR(2 downto 0);
        IF_ID_RegisterRt     : IN STD_LOGIC_VECTOR(2 downto 0);
        Hazard_Detected      : OUT STD_LOGIC
    );
END HazardDetectionUnit;

ARCHITECTURE rtl OF HazardDetectionUnit IS

    SIGNAL RtRs_Equal, RtRt_Equal                                                 : STD_LOGIC;
    SIGNAL ID_EX_RegisterRt_8_BIT, IF_ID_RegisterRs_8_BIT, IF_ID_RegisterRt_8_BIT : STD_LOGIC_VECTOR(7 downto 0);

    COMPONENT EightBitComparator IS
        PORT(
            i_Ai, i_Bi			    : IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_GT, o_LT, o_EQ		: OUT	STD_LOGIC
        );
    END COMPONENT;

BEGIN

    -- Concatenation to convert 3-bit signals to 8-bit signals
    ID_EX_RegisterRt_8_BIT <= "00000" & ID_EX_RegisterRt;
    IF_ID_RegisterRs_8_BIT <= "00000" & IF_ID_RegisterRs;
    IF_ID_RegisterRt_8_BIT <= "00000" & IF_ID_RegisterRt;

    -- First Comparator: ID/EX.RegisterRt and IF/ID.RegisterRs
    Comparator1 : EightBitComparator
        PORT MAP (
            i_Ai => ID_EX_RegisterRt_8_BIT,
            i_Bi => IF_ID_RegisterRs_8_BIT,
            o_GT => OPEN,
            o_EQ => RtRs_Equal,
            o_LT => OPEN
        );

    -- Second Comparator: ID/EX.RegisterRt and IF/ID.RegisterRt
    Comparator2 : EightBitComparator
        PORT MAP (
            i_Ai => ID_EX_RegisterRt_8_BIT,
            i_Bi => IF_ID_RegisterRt_8_BIT,
            o_GT => OPEN,
            o_EQ => RtRt_Equal,
            o_LT => OPEN
        );

    -- Hazard Detection Logic
    Hazard_Detected <= (ID_EX_MemRead AND RtRs_Equal) OR RtRt_Equal;

END ARCHITECTURE;
