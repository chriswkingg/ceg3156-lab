LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MultiplierFinal is
    PORT
    (
        IN1, IN2    :   IN STD_LOGIC_VECTOR(8 downto 0);
        CLK, async_reset_bar         :   IN STD_LOGIC;
        Product     :   OUT STD_LOGIC_VECTOR(17 downto 0)
    );
    END MultiplierFinal;

ARCHITECTURE rtl of MultiplierFinal is
    SIGNAL LSHFTA,RSHFTB,LDA,LDB,INCI,CLRI,LDP,CLRP, B0IS1, ILT7     : STD_LOGIC;
    COMPONENT MultiplierCP is
        PORT
        (
            B0IS1, RESET, CLK, ILT7   : IN  STD_LOGIC;
            LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP    : OUT STD_LOGIC
        );
        END COMPONENT;
    
    COMPONENT MultiplierDP is
        PORT 
        (
            IN1, IN2    :   IN STD_LOGIC_VECTOR(8 downto 0);
            LSHFTA, RSHFTB, LDA, LDB, INCI, CLRI, LDP, CLRP, RESET, CLK    : IN STD_LOGIC;
            ILT7, B0IS1 :   OUT STD_LOGIC;
            Product     :   OUT STD_LOGIC_VECTOR(17 downto 0)

        );
        END COMPONENT;   
    
    BEGIN
    CP  : MultiplierCP
        PORT MAP
        (
            B0IS1 => B0IS1,
            RESET => async_reset_bar,
            CLK => CLK,
            LSHFTA => LSHFTA,
            RSHFTB => RSHFTB,
            LDA => LDA,
            LDB => LDB,
            INCI => INCI,
            CLRI => CLRI,
            LDP => LDP,
            CLRP => CLRP,
            ILT7 => ILT7
        );

    DP  :  MultiplierDP
        PORT MAP
        (
            IN1 => IN1,
            IN2 => IN2, 
            LSHFTA => LSHFTA,
            RSHFTB => RSHFTB,
            LDA => LDA,
            LDB => LDB,
            INCI => INCI,
            CLRI => CLRI,
            LDP => LDP,
            CLRP => CLRP,
            RESET => async_reset_bar,
            CLK => CLK,
            ILT7 => ILT7,
            B0IS1 => B0IS1,
            Product => Product
        );
        

    end rtl;