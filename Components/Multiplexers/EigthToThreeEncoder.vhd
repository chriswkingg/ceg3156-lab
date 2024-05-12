LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EigthToThreeEncoder IS
    PORT 
    (
        inputs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        outputs : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    );
END ENTITY EigthToThreeEncoder;

ARCHITECTURE rtl OF EigthToThreeEncoder IS

BEGIN

    outputs(2) <= inputs(7) + inputs(6) + inputs(5) + inputs(4);
    outputs(1) <= inputs(7) + inputs(6) + inputs(3) + inputs(2);
    outputs(0) <= inputs(7) + inputs(5) + inputs(3) + inputs(1); 

END rtl;
