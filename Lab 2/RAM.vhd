LIBRARY ieee, lpm;
USE ieee.std_logic_1164.ALL;
USE lpm.lpm_components.ALL;


ENTITY RAM IS
    PORT 
    (
		i_data: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_address: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_clock : IN STD_LOGIC;
      i_we: IN STD_LOGIC;
      o_data: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END RAM;

ARCHITECTURE ram OF RAM IS
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
		address => i_address,
		inclock => i_clock,
		data => i_data,
		we => i_we,
		q => o_data
	);

END ARCHITECTURE;