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
SIGNAL int_dataAddress, int_readData, int_writeData, int_instructionAddress : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL int_instructionMemoryOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL i_memWrite : STD_LOGIC;
BEGIN
	dataMemory : lpm_ram_dq
	GENERIC MAP (
		lpm_address_control => "REGISTERED",
		lpm_file => "dataMemory.mif",
		lpm_indata => "REGISTERED",
		lpm_outdata => "UNREGISTERED",
		lpm_type => "LPM_RAM_DQ",
		lpm_width => 8,
		lpm_widthad => 8
	)
	PORT MAP (
		address => int_dataAddress,
		inclock => i_clock,
		data => int_writeData,
		we => i_memWrite,
		q => int_readData
	);

   instructionMemory : lpm_rom
	GENERIC MAP (
		lpm_address_control => "REGISTERED",
		lpm_file => "instructionMemory.mif",
		lpm_indata => "REGISTERED",
		lpm_outdata => "UNREGISTERED",
		lpm_type => "LPM_RAM_DQ",
		lpm_width => 32,
		lpm_widthad => 8
	)
	PORT MAP (
		address => int_instructionAddress,
		inclock => i_clock,
		q => int_instructionMemoryOut
	);
END rtl;
