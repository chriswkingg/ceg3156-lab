LIBRARY ieee, lpm;
USE ieee.std_logic_1164.ALL;
USE lpm.lpm_components.ALL;

ENTITY Processor IS
    PORT (
        i_valueSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_clock, i_reset : IN STD_LOGIC;
        o_muxOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_instructionOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_branch, o_zero, o_memwrite, o_regwrite : OUT STD_LOGIC;
        o_IFID_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_IFID_pc : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_IDEX_pc, o_IDEX_reg1, o_IDEX_reg2, o_IDEX_offset : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_IDEX_rd1, o_IDEX_rd2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_EXMEM_branchAddr, o_EXMEM_aluResult, o_EXMEM_reg2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_EXMEM_regDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_EXMEM_zeroFlag : OUT STD_LOGIC;
        o_MEMWB_memReadData, o_MEMWB_aluResult : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_MEMWB_regDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  o_FwdA, o_FwdB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		  o_Stall : OUT STD_LOGIC
    );
END ENTITY Processor;

ARCHITECTURE rtl OF Processor IS

    -- Component Declarations
    COMPONENT ROM
    PORT (
        i_address: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_clock : IN STD_LOGIC;
        o_data: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT RAM
    PORT (
        i_data: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_address: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_clock : IN STD_LOGIC;
        i_we: IN STD_LOGIC;
        o_data: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT ALU
    PORT (
        i_OPERAND_1, i_OPERAND_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_OPERATION : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_RESULT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_ZERO : OUT STD_LOGIC;
        o_OVERFLOW : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT ALUControlUnit 
    PORT (
        i_FUNC_CODE : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        i_ALU_OP : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        o_OPERATION : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT RegisterFile
    PORT (
        i_readSelect1, i_readSelect2, i_writeSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_writeData : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_clock, i_reset, i_regWrite : IN STD_LOGIC;
        o_readData1, o_readData2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT ControlUnit
    PORT (
        i_op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        o_RegDest, o_ALUSrc, o_MemToReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT TwoToOne8BitMux
    PORT (
        i_muxIn0, i_muxIn1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_mux : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel : IN STD_LOGIC
    );
    END COMPONENT;

    COMPONENT EightBitGPRegister 
    PORT (
        -- Register Operations
        i_resetBar : IN STD_LOGIC;
        i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
        i_decrement, i_increment : IN STD_LOGIC;
        -- Register Signals
        i_serial_in_left, i_serial_in_right : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT EightBitAdderSubtractor 
    PORT (
        InputA, InputB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Operation : IN STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        CarryOUT : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT SignExtend16To32BitModule 
    PORT (
        i_OPERAND : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        o_OUTPUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT TwoToOne32BitMux
    PORT (
        i_muxIn0, i_muxIn1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_mux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel : IN STD_LOGIC
    );
    END COMPONENT;

    COMPONENT ThirtyTwoBitAdderSubtractor 
    PORT (
        InputA, InputB : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Operation : IN STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        CarryOUT : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT FourToOne8BitMux
    PORT (
        i_muxIn0, i_muxIn1, i_muxIn2, i_muxIn3: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_mux: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel0, sel1: IN STD_LOGIC
    );
    END COMPONENT;

    COMPONENT IFID
    PORT (
        i_clock, i_reset : IN STD_LOGIC;
        i_instructionRegister : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
        i_PC : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_instructionRegister : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        o_PC : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT IDEX
    PORT (
        i_clock, i_reset : IN STD_LOGIC;
        i_PC, i_reg1, i_reg2, i_offset : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_rd1, i_rd2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_PC, o_reg1, o_reg2, o_offset : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_rd1, o_rd2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT EXMEM
    PORT (
        i_clock, i_reset, i_zeroFlag : IN STD_LOGIC;
        i_branchAddr, i_aluResult, i_reg2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_regDest : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_branchAddr, o_aluResult, o_reg2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_regDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_zeroFlag : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT MEMWB
    PORT (
        i_clock, i_reset : IN STD_LOGIC;
        i_memReadData, i_aluResult : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_regDest : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        o_memReadData, o_aluResult : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_regDest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT ForwardingUnit
    PORT 
    (
        i_MEM_WB_Rd, i_EX_MEM_Rd, i_ID_EX_Rs, i_ID_EX_Rt  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        i_MEM_WB_RegWrite, i_EX_MEM_RegWrite  : IN STD_LOGIC;
        o_ForwardA, o_ForwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT HazardDetectionUnit
    PORT
    (
        ID_EX_MemRead        : IN STD_LOGIC;
        ID_EX_RegisterRt     : IN STD_LOGIC_VECTOR(2 downto 0);
        IF_ID_RegisterRs     : IN STD_LOGIC_VECTOR(2 downto 0);
        IF_ID_RegisterRt     : IN STD_LOGIC_VECTOR(2 downto 0);
        Hazard_Detected      : OUT STD_LOGIC
    );
    END COMPONENT;

    -- Signals
    SIGNAL i_resetBar : STD_LOGIC;
    SIGNAL int_dataAddress, int_readDataMemory, int_writeData, int_instructionAddress : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL pc_increment, instruction_address : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL pc_increment_long, instruction_address_extended : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL int_aluOperandA, int_aluOperandB, int_aluResult : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL int_aluOperation : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL int_instructionMemoryOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL int_readData1, int_readData2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL int_control_ALUOP : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL int_RegDest, int_ALUSrc, int_MemToReg, int_RegWrite, int_MemWrite, int_Branch : STD_LOGIC;
    SIGNAL int_offset_Truncated : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL int_offset : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL int_offset_SE : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ifid_instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ifid_pc, idex_pc, idex_reg1, idex_reg2, idex_offset : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL idex_rd1, idex_rd2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL exmem_branchAddr, exmem_aluResult, exmem_reg2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL exmem_regDest : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL exmem_zeroFlag : STD_LOGIC;
    SIGNAL memwb_memReadData, memwb_aluResult : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL memwb_regDest : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL fwdA, fwdB : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    -- Load Program Counter
    PCRegister : EightBitGPRegister PORT MAP (
        i_resetBar => i_resetBar,
        i_load => '1', i_shiftLeft => '0', i_shiftRight => '0',
        i_decrement => '0', i_increment => '0',
        i_serial_in_left => '0', i_serial_in_right => '0',
        i_clock => i_clock,
        i_Value => instruction_address,
        o_Value => int_instructionAddress
    );

    -- Program Counter Adder
    PCAdder : EightBitAdderSubtractor PORT MAP (
        InputA => int_instructionAddress,
        InputB => "00000001",
        Operation => '0',
        Result => pc_increment,
        CarryOUT => OPEN
    );

    -- Program Counter Multiplexer
    PCMux : TwoToOne8BitMux PORT MAP (
        i_muxIn0 => pc_increment,
        i_muxIn1 => int_instructionAddress,
        sel => '0',
        o_mux => instruction_address
    );

    -- Instruction Memory
    InstructionMemory : ROM PORT MAP (
        i_address => int_instructionAddress,
        i_clock => i_clock,
        o_data => int_instructionMemoryOut
    );

    -- Instruction Fetch to Decode Pipeline Register
    IFIDPipeReg : IFID PORT MAP (
        i_clock => i_clock,
        i_reset => i_reset,
        i_instructionRegister => int_instructionMemoryOut,
        i_PC => pc_increment,
        o_instructionRegister => ifid_instruction,
        o_PC => ifid_pc
    );

    -- Control Unit
    ControlUnit1 : ControlUnit PORT MAP (
        i_op => ifid_instruction(31 DOWNTO 26),
        o_RegDest => int_RegDest,
        o_ALUSrc => int_ALUSrc,
        o_MemToReg => int_MemToReg,
        o_RegWrite => int_RegWrite,
        o_MemRead => OPEN,
        o_MemWrite => int_MemWrite,
        o_Branch => int_Branch,
        o_ALUOp0 => int_control_ALUOP(0),
        o_ALUOp1 => int_control_ALUOP(1),
        o_jump => OPEN
    );

    -- Register File
    RegisterFile1 : RegisterFile PORT MAP (
        i_readSelect1 => ifid_instruction(23 DOWNTO 21),
        i_readSelect2 => ifid_instruction(18 DOWNTO 16),
        i_writeSelect => memwb_regDest,
        i_writeData => memwb_aluResult,
        i_clock => i_clock,
        i_reset => i_reset,
        i_regWrite => int_RegWrite,
        o_readData1 => int_readData1,
        o_readData2 => int_readData2
    );

    -- Hazard Detection Unit
    HazDetUnit : HazardDetectionUnit PORT MAP (
        ID_EX_MemRead => '1',
        IF_ID_RegisterRs => ifid_instruction(23 DOWNTO 21),
        IF_ID_RegisterRt => ifid_instruction(18 DOWNTO 16),
        ID_EX_RegisterRt => idex_rd2,
			Hazard_Detected => o_stall
    );

    -- Decode to Execute Pipeline Register
    IDEXPipeReg : IDEX PORT MAP (
        i_clock => i_clock,
        i_reset => i_reset,
        i_PC => ifid_pc,
        i_reg1 => int_readData1,
        i_reg2 => int_readData2,
        i_offset => int_offset_SE(7 DOWNTO 0),
        i_rd1 => ifid_instruction(23 DOWNTO 21),
        i_rd2 => ifid_instruction(18 DOWNTO 16),
        o_PC => idex_pc,
        o_reg1 => idex_reg1,
        o_reg2 => idex_reg2,
        o_offset => idex_offset,
        o_rd1 => idex_rd1,
        o_rd2 => idex_rd2
    );

    -- ALU Operand A Multiplexer
    ALUOperandAMux : TwoToOne8BitMux PORT MAP (
        i_muxIn0 => idex_reg1,
        i_muxIn1 => exmem_aluResult,
        sel => fwdA(0),
        o_mux => int_aluOperandA
    );

    -- ALU Operand B Multiplexer
    ALUOperandBMux : TwoToOne8BitMux PORT MAP (
        i_muxIn0 => idex_reg2,
        i_muxIn1 => idex_offset,
        sel => int_ALUSrc,
        o_mux => int_aluOperandB
    );

    -- ALU Control Unit
    ALUControl : ALUControlUnit PORT MAP (
        i_FUNC_CODE => idex_offset(5 DOWNTO 0),
        i_ALU_OP => int_control_ALUOP,
        o_OPERATION => int_aluOperation
    );

    -- ALU
    ALU1 : ALU 
	 PORT MAP (
        i_OPERAND_1 => int_aluOperandA,
        i_OPERAND_2 => int_aluOperandB,
        i_OPERATION => int_aluOperation,
        o_RESULT => int_aluResult,
        o_ZERO => OPEN,
        o_OVERFLOW => OPEN
    );

    -- Forwarding Unit
    FwdUnit : ForwardingUnit 
	 PORT MAP (
        i_ID_EX_Rs => idex_rd1,
		  i_ID_EX_Rt => idex_rd2,
        i_EX_MEM_Rd => exmem_regDest,
        i_MEM_WB_Rd => memwb_regDest,
        i_EX_MEM_RegWrite => '1',
        i_MEM_WB_RegWrite => int_RegWrite,
        o_ForwardA => fwdA,
        o_ForwardB => fwdB
    );

    -- Execute to Memory Pipeline Register
    EXMEMPipeReg : EXMEM PORT MAP (
        i_clock => i_clock,
        i_reset => i_reset,
        i_zeroFlag => '1',
        i_branchAddr => "00000000",
        i_aluResult => int_aluResult,
        i_reg2 => idex_reg2,
        i_regDest => idex_rd2,
        o_branchAddr => exmem_branchAddr,
        o_aluResult => exmem_aluResult,
        o_reg2 => exmem_reg2,
        o_regDest => exmem_regDest,
        o_zeroFlag => exmem_zeroFlag
    );

    -- Data Memory
    DataMemory : RAM PORT MAP (
        i_data => exmem_reg2,
        i_address => exmem_aluResult,
        i_clock => i_clock,
        i_we => int_MemWrite,
        o_data => int_readDataMemory
    );

    -- Memory to Writeback Pipeline Register
    MEMWBPipeReg : MEMWB PORT MAP (
        i_clock => i_clock,
        i_reset => i_reset,
        i_memReadData => int_readDataMemory,
        i_aluResult => exmem_aluResult,
        i_regDest => exmem_regDest,
        o_memReadData => memwb_memReadData,
        o_aluResult => memwb_aluResult,
        o_regDest => memwb_regDest
    );

    -- Multiplex the output
    Multiplexer : FourToOne8BitMux PORT MAP (
        i_muxIn0 => int_instructionAddress,
        i_muxIn1 => int_aluResult,
        i_muxIn2 => int_readData1,
        i_muxIn3 => int_readData2,
        o_mux => o_muxOut,
        sel0 => i_valueSelect(1),
        sel1 => i_valueSelect(2)
    );

    -- Output Signals
    o_instructionOut <= ifid_instruction;
    o_branch <= int_Branch;
    o_zero <= exmem_zeroFlag;
    o_memwrite <= int_MemWrite;
    o_regwrite <= int_RegWrite;
    o_instructionOut <= ifid_instruction;
    o_branch <= int_Branch;
    o_zero <= exmem_zeroFlag;
    o_memwrite <= int_MemWrite;
    o_regwrite <= int_RegWrite;
    o_IFID_instruction <= ifid_instruction;
    o_IFID_pc <= ifid_pc;
    o_IDEX_pc <= idex_pc;
    o_IDEX_reg1 <= idex_reg1;
    o_IDEX_reg2 <= idex_reg2;
    o_IDEX_offset <= idex_offset;
    o_IDEX_rd1 <= idex_rd1;
    o_IDEX_rd2 <= idex_rd2;
    o_EXMEM_branchAddr <= exmem_branchAddr;
    o_EXMEM_aluResult <= exmem_aluResult;
    o_EXMEM_reg2 <= exmem_reg2;
    o_EXMEM_regDest <= exmem_regDest;
    o_EXMEM_zeroFlag <= exmem_zeroFlag;
    o_MEMWB_memReadData <= memwb_memReadData;
    o_MEMWB_aluResult <= memwb_aluResult;
    o_MEMWB_regDest <= memwb_regDest;
	 
	 o_FwdA <= fwdA;
	 o_FwdB <= fwdB;
END ARCHITECTURE rtl;
