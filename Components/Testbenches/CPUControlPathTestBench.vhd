LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPUControlPathTestBench IS
END CPUControlPathTestBench;

ARCHITECTURE behavior OF CPUControlPathTestBench IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ControlUnit
    PORT(
         i_op : IN  std_logic_vector(5 downto 0);
         o_RegDest : OUT  std_logic;
         o_ALUSrc : OUT  std_logic;
         o_MemToReg : OUT  std_logic;
         o_RegWrite : OUT  std_logic;
         o_MemRead : OUT  std_logic;
         o_MemWrite : OUT  std_logic;
         o_Branch : OUT  std_logic;
         o_ALUOp0 : OUT  std_logic;
         o_ALUOp1 : OUT  std_logic;
         o_jump : OUT  std_logic
        );
    END COMPONENT;
   
   -- Inputs
   signal i_op : std_logic_vector(5 downto 0) := (others => '0');

   -- Outputs
   signal o_RegDest : std_logic;
   signal o_ALUSrc : std_logic;
   signal o_MemToReg : std_logic;
   signal o_RegWrite : std_logic;
   signal o_MemRead : std_logic;
   signal o_MemWrite : std_logic;
   signal o_Branch : std_logic;
   signal o_ALUOp0 : std_logic;
   signal o_ALUOp1 : std_logic;
   signal o_jump : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ControlUnit PORT MAP (
          i_op => i_op,
          o_RegDest => o_RegDest,
          o_ALUSrc => o_ALUSrc,
          o_MemToReg => o_MemToReg,
          o_RegWrite => o_RegWrite,
          o_MemRead => o_MemRead,
          o_MemWrite => o_MemWrite,
          o_Branch => o_Branch,
          o_ALUOp0 => o_ALUOp0,
          o_ALUOp1 => o_ALUOp1,
          o_jump => o_jump
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- R-format instruction
        i_op <= "000000"; wait for 100 ns;
        assert (o_RegDest = '1' and o_ALUSrc = '0' and o_MemToReg = '0' and o_RegWrite = '1' and
                o_MemRead = '0' and o_MemWrite = '0' and o_Branch = '0' and o_ALUOp0 = '0' and o_ALUOp1 = '1' and o_jump = '0');

        -- lw instruction
        i_op <= "100011"; wait for 100 ns;
        assert (o_RegDest = '0' and o_ALUSrc = '1' and o_MemToReg = '1' and o_RegWrite = '1' and
                o_MemRead = '1' and o_MemWrite = '0' and o_Branch = '0' and o_ALUOp0 = '0' and o_ALUOp1 = '0' and o_jump = '0');

        -- sw instruction
        i_op <= "101011"; wait for 100 ns;
        assert (o_RegDest = 'X' and o_ALUSrc = '1' and o_MemToReg = 'X' and o_RegWrite = '0' and
                o_MemRead = '0' and o_MemWrite = '1' and o_Branch = '0' and o_ALUOp0 = '0' and o_ALUOp1 = '0' and o_jump = '0');

        -- beq instruction
        i_op <= "000100"; wait for 100 ns;
        assert (o_RegDest = 'X' and o_ALUSrc = '0' and o_MemToReg = 'X' and o_RegWrite = '0' and
                o_MemRead = '0' and o_MemWrite = '0' and o_Branch = '1' and o_ALUOp0 = '1' and o_ALUOp1 = '0' and o_jump = '0');

        -- jump instruction
        i_op <= "000010"; wait for 100 ns;
        assert (o_RegDest = 'X' and o_ALUSrc = '0' and o_MemToReg = 'X' and o_RegWrite = '0' and
                o_MemRead = '0' and o_MemWrite = '0' and o_Branch = '0' and o_ALUOp0 = '0' and o_ALUOp1 = '0' and o_jump = '1');

        wait;
    end process;

END;
