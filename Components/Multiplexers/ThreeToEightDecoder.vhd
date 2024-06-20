LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThreeToEightDecoder IS
    PORT 
    (
        inputs : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        outputs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY ThreeToEightDecoder;

ARCHITECTURE rtl OF ThreeToEightDecoder IS

BEGIN
	outputs(0) <= not(inputs(0)) and not(inputs(1)) and not(inputs(2));
	outputs(1) <= (inputs(0)) and not(inputs(1)) and not(inputs(2));
	outputs(2) <= not(inputs(0)) and (inputs(1)) and not(inputs(2));
	outputs(3) <= (inputs(0)) and (inputs(1)) and not(inputs(2));
	outputs(4) <= not(inputs(0)) and not(inputs(1)) and (inputs(2));
	outputs(5) <= (inputs(0)) and not(inputs(1)) and (inputs(2));
	outputs(6) <= not(inputs(0)) and (inputs(1)) and (inputs(2));
	outputs(7) <= (inputs(0)) and (inputs(1)) and (inputs(2));
END rtl;
