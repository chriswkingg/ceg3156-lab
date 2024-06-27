LIBRARY ieee, lpm;
USE ieee.std_logic_1164.ALL;
USE lpm.lpm_components.ALL;

ENTITY Processor IS
    PORT 
    (
		i_valueSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		i_clock, i_reset : IN STD_LOGIC;
		o_muxOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_instructionOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_branch, o_zero, o_memwrite, o_regwrite : OUT STD_LOGIC
    );
END ENTITY Processor;

ARCHITECTURE rtl OF Processor IS
	COMPONENT ROM
	PORT 
    (
      i_address: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_clock : IN STD_LOGIC;
      o_data: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
	END COMPONENT;
	COMPONENT RAM
	PORT 
    (
		i_data: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_address: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_clock : IN STD_LOGIC;
      i_we: IN STD_LOGIC;
      o_data: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
   END COMPONENT;

   COMPONENT ALU
   PORT 
      (
         i_OPERAND_1, i_OPERAND_2    : IN STD_LOGIC_VECTOR(7 downto 0);
         i_OPERATION                 : IN STD_LOGIC_VECTOR(2 downto 0);
         o_RESULT                    : OUT STD_LOGIC_VECTOR(7 downto 0);
         o_ZERO                      : OUT STD_LOGIC;
         o_OVERFLOW                  : OUT STD_LOGIC
      );
   END COMPONENT;

   COMPONENT ALUControlUnit 
   PORT 
    (
        i_FUNC_CODE : IN STD_LOGIC_VECTOR(5 downto 0);
        i_ALU_OP    : IN STD_LOGIC_VECTOR(1 downto 0);
        o_OPERATION : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
   END COMPONENT;

   COMPONENT RegisterFile
   PORT 
    (
        i_readSelect1, i_readSelect2, i_writeSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  i_writeData : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  i_clock, i_reset, i_regWrite : IN STD_LOGIC;
        o_readData1, o_readData2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
   END COMPONENT;

   COMPONENT ControlUnit
   PORT
    (
        i_op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        o_RegDest, o_ALUSrc, o_MemToReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : OUT STD_LOGIC
    );
   END COMPONENT;

   COMPONENT TwoToOne8BitMux IS
   PORT (
        i_muxIn0, i_muxIn1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_mux				: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel					: IN STD_LOGIC
   );
   END COMPONENT;

   -- Memory signals
   SIGNAL int_dataAddress, int_readDataMemory, int_writeData, int_instructionAddress : STD_LOGIC_VECTOR(7 DOWNTO 0);
   -- ALU Signals
   SIGNAL int_aluOperandA, int_aluOperandB, int_aluResult : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL int_aluOperation : STD_LOGIC_VECTOR(2 DOWNTO 0);

   SIGNAL int_instructionMemoryOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
   
   -- Register File Signals
   SIGNAL int_readData1, int_readData2 : STD_LOGIC_VECTOR(7 DOWNTO 0);

   -- Control Signals
   SIGNAL int_control_ALUOP : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL int_regWrite, int_memWrite : STD_LOGIC;

   COMPONENT EightBitGPRegister IS
      PORT 
      (
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

   COMPONENT EightBitAdderSubtractor is 
    PORT
    (
        InputA, InputB  : IN STD_LOGIC_VECTOR(7 downto 0);
        Operation   :   IN STD_LOGIC;
        Result    :   OUT STD_LOGIC_VECTOR(7 downto 0);
        CarryOUT    :   OUT STD_LOGIC
    );
    END COMPONENT;

   COMPONENT ControlUnit is
    PORT
    (
        i_op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        o_RegDest, o_ALUSrc, o_MemToReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : OUT STD_LOGIC
    );
    END COMPONENT;
   
   COMPONENT SignExtend16To32BitModule IS 
      PORT 
      (
         i_OPERAND       : IN STD_LOGIC_VECTOR(15 downto 0);
         o_OUTPUT        : OUT STD_LOGIC_VECTOR(31 downto 0)
      );
   END COMPONENT;

   COMPONENT TwoToOne8BitMux IS
   PORT (
      i_muxIn0, i_muxIn1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      o_mux				: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      sel					: IN STD_LOGIC
   );
   END COMPONENT;
   
   COMPONENT ALUControlUnit IS 
   PORT 
   (
      i_FUNC_CODE : IN STD_LOGIC_VECTOR(5 downto 0);
      i_ALU_OP    : IN STD_LOGIC_VECTOR(1 downto 0);
      o_OPERATION : OUT STD_LOGIC_VECTOR(2 downto 0)
   );
   END COMPONENT;

BEGIN
	dataMemory : RAM
	PORT MAP (
		i_address => int_dataAddress,
		i_clock => i_clock,
		i_data => int_writeData,
		i_we => int_memWrite,
		o_data => int_readDataMemory
	);

   instructionMemory : ROM
	PORT MAP (
		i_address => int_instructionAddress,
		i_clock => i_clock,
		o_data => int_instructionMemoryOut
	);
   
   arithmeticLogicUnit : ALU
   PORT MAP
      (
         i_OPERAND_1 => int_aluOperandA, 
         i_OPERAND_2 => int_aluOperandB,
         i_OPERATION => int_aluOperation,
         o_RESULT => int_aluResult,
         o_ZERO => open,
         o_OVERFLOW => open
      );
   aluControl : ALUControlUnit 
   PORT MAP
    (
        i_FUNC_CODE => int_instructionMemoryOut(5 DOWNTO 0),
        i_ALU_OP => int_control_ALUOP,
        o_OPERATION => int_aluOperation
    );

   control : ControlUnit
   PORT MAP
    (
        i_op => int_instructionMemoryOut(31 DOWNTO 26),
        o_RegDest => open, 
        o_ALUSrc => open, 
        o_MemToReg => open, 
        o_RegWrite => int_regWrite, 
        o_MemRead => int_memWrite, 
        o_MemWrite => open, 
        o_Branch => open, 
        o_ALUOp0 => int_control_ALUOP(0), 
        o_ALUOp1 => int_control_ALUOP(1), 
        o_jump => open
    );
   registers : RegisterFile
   PORT MAP
    (
        i_readSelect1 => int_instructionMemoryOut(23 DOWNTO 21),
        i_readSelect2 => int_instructionMemoryOut(18 DOWNTO 16),
        i_writeSelect => "000",
		  i_writeData => "00000000",
		  i_clock => i_clock, 
        i_reset => i_reset,
        i_regWrite => int_regWrite,
        o_readData1 => int_readData1,
        o_readData2 => int_readData2
    );
    int_aluOperandA <= int_readData1;
END rtl;
