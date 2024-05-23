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

echo Compiling Lab1 Circuits
echo:
ghdl -a "..\Lab 1\*.vhd"

echo Simulating Testbenches
echo:
ghdl -a .\Testbenches\*.vhd
ghdl -r EncoderTestBench --vcd=.\Testbenches\Results\EncoderTestBench.vcd
ghdl -r NineBitAdderSubtractorTestBench --vcd=.\Testbenches\Results\NineBitAdderSubtractorTestBench.vcd
ghdl -r NineBitGPRegisterTestBench --vcd=.\Testbenches\Results\NineBitGPRegisterTestBench.vcd
ghdl -r dflipflopTestBench --vcd=.\Testbenches\Results\dflipflopTestBench.vcd
ghdl -r MultiplierFinalTestBench --vcd=.\Testbenches\Results\MultiplierFinalTestBench.vcd
ghdl -r FloatingPointAdderTestbench --vcd=.\Testbenches\Results\FloatingPointAdderTestbench.vcd


echo:

echo Done
