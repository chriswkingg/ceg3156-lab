@ECHO OFF
echo:
echo --------Compiling VHD Component Files--------
echo:
echo:
echo:

echo Compiling Adders Circuits
echo:
ghdl -a .\Adders\*.vhd
echo:

echo Compiling Compartors Circuits
echo:
ghdl -a .\Comparator\*.vhd
echo:

echo Compiling Flip Flop Circuits
echo:
ghdl -a .\FlipFlops\*.vhd
echo:

echo Compiling Multiplexers Circuits
echo:
ghdl -a .\Multiplexers\*.vhd
echo:

echo Compiling Multipliers Circuits
echo:
ghdl -a .\Multipliers\*.vhd
echo:

echo Compiling Registers Circuits
echo:
ghdl -a .\Registers\*.vhd
echo:

echo Compiling SignExtend Modules
echo:
ghdl -a .\SignExtend\*.vhd
echo:

@REM echo Compiling Lab1 Circuits
@REM echo:
@REM ghdl -a "..\Lab 1\*.vhd"

echo Compiling Lab2 Circuits
echo:
ghdl -a "..\Lab 2\*.vhd"

echo Simulating Testbenches
echo:
ghdl -a .\Testbenches\*.vhd
@REM Lab 1 Testbenches
@REM ghdl -r EncoderTestBench --vcd=.\Testbenches\Results\EncoderTestBench.vcd
@REM ghdl -r NineBitAdderSubtractorTestBench --vcd=.\Testbenches\Results\NineBitAdderSubtractorTestBench.vcd
@REM ghdl -r NineBitGPRegisterTestBench --vcd=.\Testbenches\Results\NineBitGPRegisterTestBench.vcd
@REM ghdl -r dflipflopTestBench --vcd=.\Testbenches\Results\dflipflopTestBench.vcd
@REM ghdl -r MultiplierFinalTestBench --vcd=.\Testbenches\Results\MultiplierFinalTestBench.vcd
@REM ghdl -r FloatingPointAdderTestbench --vcd=.\Testbenches\Results\FloatingPointAdderTestbench.vcd

@REM Lab 2 Testbenches
ghdl -r ALUTestBench --vcd=.\Testbenches\Results\ALUTestBench.vcd
ghdl -r SignExtend16To32BitModuleTestBench --vcd=.\Testbenches\Results\SignExtend16To32BitModule.vcd
ghdl -r CPUControlPathTestBench --vcd=.\Testbenches\Results\CPUControlPathTestBench.vcd


echo:

echo Done
