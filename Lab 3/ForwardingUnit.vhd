LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ForwardingUnit IS 
    PORT 
    (
        i_MEM_WB_Rd, i_EX_MEM_Rd, i_ID_EX_Rs, i_ID_EX_Rt : STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_MEM_WB_RegWrite, i_EX_MEM_RegWrite : STD_LOGIC;
        o_ForwardA, o_ForwardB : STD_LOGIC_VECTOR(1 DOWNTO 0);
    );
END ForwardingUnit;

ARCHITECTURE RTL OF ForwardingUnit IS
    COMPONENT EightBitComparator
    PORT(
		i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_GT, o_LT, o_EQ		: OUT	STD_LOGIC
	);
    END COMPONENT;
    SIGNAL MEM_WB_Rd_Not_Zero, EX_MEM_Rd_Not_Zero : STD_LOGIC;
    SIGNAL Eight_Bit_MEM_WB_Rd, Eight_Bit_EX_MEM_Rd, Eight_Bit_ID_EX_Rs, Eight_Bit_ID_EX_Rt : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL MEM_WB_Rd_Eq_ID_EX_Rs, EX_MEM_Rd_Eq_ID_EX_Rs, MEM_WB_Rd_Eq_ID_EX_Rt, EX_MEM_Rd_Eq_ID_EX_Rt : STD_LOGIC;
    SIGNAL int_ForwardA, int_ForwardB : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    MEM_WB_Rd_Not_Zero <= i_MEM_WB_Rd(0) OR i_MEM_WB_Rd(1) OR i_MEM_WB_Rd(2);
    EX_MEM_Rd_Not_Zero <= i_EX_MEM_Rd(0) OR i_EX_MEM_Rd(1) OR i_EX_MEM_Rd(2);
    Eight_Bit_MEM_WB_Rd <= "00000" & i_MEM_WB_Rd;
    Eight_Bit_EX_MEM_Rd <= "00000" & i_EX_MEM_Rd;
    Eight_Bit_ID_EX_Rs <= "00000" & i_ID_EX_Rs;
    Eight_Bit_ID_EX_Rt <= "00000" & i_ID_EX_Rt;

    comp0 : EightBitComparator
    PORT MAP(
        i_Ai => Eight_Bit_MEM_WB_Rd,
        i_Bi => Eight_Bit_ID_EX_Rs,
		o_GT => open,
        o_LT => open,
        o_EQ => MEM_WB_Rd_Eq_ID_EX_Rs
    );
    comp1 : EightBitComparator
    PORT MAP(
        i_Ai => Eight_Bit_EX_MEM_Rd,
        i_Bi => Eight_Bit_ID_EX_Rs,
		o_GT => open,
        o_LT => open,
        o_EQ => EX_MEM_Rd_Eq_ID_EX_Rs
    );
    comp2 : EightBitComparator
    PORT MAP(
        i_Ai => Eight_Bit_MEM_WB_Rd,
        i_Bi => Eight_Bit_ID_EX_Rt,
		o_GT => open,
        o_LT => open,
        o_EQ => MEM_WB_Rd_Eq_ID_EX_Rt
    );
    comp3 : EightBitComparator
    PORT MAP(
        i_Ai => Eight_Bit_EX_MEM_Rd,
        i_Bi => Eight_Bit_ID_EX_Rt,
		o_GT => open,
        o_LT => open,
        o_EQ => EX_MEM_Rd_Eq_ID_EX_Rt
    );

    int_ForwardA(0) <= MEM_WB_Rd_Eq_ID_EX_Rs AND MEM_WB_Rd_Not_Zero AND i_MEM_WB_RegWrite AND NOT int_ForwardA(1);
    int_ForwardA(1) <= EX_MEM_Rd_Eq_ID_EX_Rs AND EX_MEM_Rd_Not_Zero AND i_EX_MEM_RegWrite;
    int_ForwardB(0) <= MEM_WB_Rd_Eq_ID_EX_Rt AND MEM_WB_Rd_Not_Zero AND i_MEM_WB_RegWrite AND NOT int_ForwardB(1);
    int_ForwardB(1) <= EX_MEM_Rd_Eq_ID_EX_Rt AND EX_MEM_Rd_Not_Zero AND i_EX_MEM_RegWrite;

    o_ForwardA <= int_ForwardA;
    o_ForwardB <= int_ForwardB;
END RTL;
