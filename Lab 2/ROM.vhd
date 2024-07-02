LIBRARY ieee, lpm;
USE ieee.std_logic_1164.ALL;
USE lpm.lpm_components.ALL;


ENTITY ROM IS
    PORT 
    (
      i_address: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_clock : IN STD_LOGIC;
      o_data: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ROM;

ARCHITECTURE ram OF ROM IS
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
BEGIN
	instructionMemory : lpm_rom
	GENERIC MAP (
		lpm_address_control => "REGISTERED",
		lpm_file => "instructionMemory.mif",
		lpm_outdata => "UNREGISTERED",
		lpm_type => "LPM_RAM_DQ",
		lpm_width => 32,
		lpm_widthad => 8
	)
	PORT MAP (
		address => i_address,
		inclock => i_clock,
		q => o_data
	);

END ARCHITECTURE;