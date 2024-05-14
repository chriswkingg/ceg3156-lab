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

echo Compiling Registers Circuits
echo:
ghdl -a .\Registers\*.vhd
echo:

echo Simulating Testbenches
echo:
ghdl -a .\Testbenches\*.vhd
ghdl -r EncoderTestBench --vcd=.\Testbenches\Results\EncoderTestBench.vcd
ghdl -r NineBitAdderSubtractorTestBench --vcd=.\Testbenches\Results\NineBitAdderSubtractorTestBench.vcd
ghdl -r NineBitGPRegisterTestBench --vcd=.\Testbenches\Results\NineBitGPRegisterTestBench.vcd
echo:

echo Done