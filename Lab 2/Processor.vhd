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
	COMPONENT lpm_rom
   GENERIC (LPM_WIDTH: POSITIVE;
      LPM_WIDTHAD: POSITIVE;
      LPM_NUMWORDS: NATURAL := 0;
      LPM_ADDRESS_CONTROL: STRING := "REGISTERED";
      LPM_OUTDATA: STRING := "REGISTERED";
      LPM_FILE: STRING;
      LPM_TYPE: STRING := "LPM_ROM";
      LPM_HINT: STRING := "UNUSED");
   PORT (address: IN STD_LOGIC_VECTOR(LPM_WIDTHAD-1 DOWNTO 0);
      inclock, outclock: IN STD_LOGIC := '0';
      memenab: IN STD_LOGIC := '1';
      q: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT lpm_ram_dq
   GENERIC (LPM_WIDTH: POSITIVE;
      LPM_WIDTHAD: POSITIVE;
      LPM_NUMWORDS: NATURAL := 0;
      LPM_INDATA: STRING := "REGISTERED";
      LPM_ADDRESS_CONTROL: STRING := "REGISTERED";
      LPM_OUTDATA: STRING := "REGISTERED";
      LPM_FILE: STRING := "UNUSED";
      LPM_TYPE: STRING := "LPM_RAM_DQ";
      LPM_HINT: STRING := "UNUSED");
    PORT (data: IN STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0);
      address: IN STD_LOGIC_VECTOR(LPM_WIDTHAD-1 DOWNTO 0);
      inclock, outclock: IN STD_LOGIC := '0';
      we: IN STD_LOGIC;
      q: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0));
END COMPONENT;

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
	
END rtl;
