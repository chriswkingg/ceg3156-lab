LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY FloatingMultiplierDPTestbench IS
END FloatingMultiplierDPTestbench;

ARCHITECTURE behavior OF FloatingMultiplierDPTestbench IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT MultiplierDataPath
        PORT(
            SignA, SignB        : IN  STD_LOGIC;
            MantissaA, MantissaB: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            ExponentA, ExponentB: IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
            GClock, GReset      : IN  STD_LOGIC;
            SignOut             : OUT STD_LOGIC;
            MantissaOut         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            ExponentOut         : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            Overflow            : OUT STD_LOGIC;
            o_INCPM, o_EXPVLD   : OUT STD_LOGIC;
            i_LDPE, i_LDAM, i_LDBM, i_overflow, i_SHFTPM, i_INCPE : IN  STD_LOGIC
        );
    END COMPONENT;

    -- Inputs
    SIGNAL SignA        : STD_LOGIC := '0';
    SIGNAL SignB        : STD_LOGIC := '0';
    SIGNAL MantissaA    : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL MantissaB    : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ExponentA    : STD_LOGIC_VECTOR(6 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ExponentB    : STD_LOGIC_VECTOR(6 DOWNTO 0) := (OTHERS => '0');
    SIGNAL GClock       : STD_LOGIC := '0';
    SIGNAL GReset       : STD_LOGIC := '0';
    SIGNAL i_LDPE       : STD_LOGIC := '0';
    SIGNAL i_LDAM       : STD_LOGIC := '0';
    SIGNAL i_LDBM       : STD_LOGIC := '0';
    SIGNAL i_overflow   : STD_LOGIC := '0';
    SIGNAL i_SHFTPM     : STD_LOGIC := '0';
    SIGNAL i_INCPE      : STD_LOGIC := '0';

    -- Outputs
    SIGNAL SignOut      : STD_LOGIC;
    SIGNAL MantissaOut  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ExponentOut  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL Overflow     : STD_LOGIC;
    SIGNAL o_INCPM      : STD_LOGIC;
    SIGNAL o_EXPVLD     : STD_LOGIC;

    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;
    signal clock_counter : natural := 0;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: MultiplierDataPath PORT MAP (
            SignA       => SignA,
            SignB       => SignB,
            MantissaA   => MantissaA,
            MantissaB   => MantissaB,
            ExponentA   => ExponentA,
            ExponentB   => ExponentB,
            GClock      => GClock,
            GReset      => GReset,
            SignOut     => SignOut,
            MantissaOut => MantissaOut,
            ExponentOut => ExponentOut,
            Overflow    => Overflow,
            o_INCPM     => o_INCPM,
            o_EXPVLD    => o_EXPVLD,
            i_LDPE      => i_LDPE,
            i_LDAM      => i_LDAM,
            i_LDBM      => i_LDBM,
            i_overflow  => i_overflow,
            i_SHFTPM    => i_SHFTPM,
            i_INCPE     => i_INCPE
        );

    -- Clock process definitions
    CLOCK_PROCESS : PROCESS
    BEGIN
        while (clock_counter < 50) loop
            GClock <= '0';
            wait for clk_period / 2;
            GClock <= '1';
            wait for clk_period / 2;
            clock_counter <= clock_counter + 1;
        end loop;
        wait;
    END PROCESS;
    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the UUT
        GReset <= '0';
        wait for clk_period*2;
        GReset <= '1';
        wait for clk_period*2;
        GReset <= '0';

        -- Apply test vectors
        SignA <= '0';
        SignB <= '1';
        MantissaA <= "00011000";  -- Example value for MantissaA
        MantissaB <= "00000110";  -- Example value for MantissaB
        ExponentA <= "0010001";   -- Example value for ExponentA
        ExponentB <= "0001101";   -- Example value for ExponentB
        i_LDPE <= '1';
        i_LDAM <= '1';
        i_LDBM <= '1';
        i_overflow <= '0';
        i_SHFTPM <= '0';
        i_INCPE <= '0';
        
        wait for clk_period*10;
        
        -- Modify inputs for another test
        MantissaA <= "00111000";
        MantissaB <= "00001110";
        ExponentA <= "0100001";
        ExponentB <= "0011101";
        
        wait for clk_period*10;
        
        -- End simulation
        wait;
    end process;

END;
