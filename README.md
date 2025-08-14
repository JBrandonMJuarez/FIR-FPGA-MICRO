# FIR-FPGA-MICRO
FIR Filter implementation on FPGA with Microcontroller for ADC reading and DAC.

The FPGA chip that includes the development board is one of the Cyclone 10 LP family of Intel-Altera with resources of up to 15 thousand logic elements, 516 Kb of memory and 122 embedded multipliers, hardware in which the implementation of the FIR filter design is synthesized. To implement the FIR filter algorithm, the mathematical expression of following Equation is taken into account.

$y[n]=\sum_{k=0}^{N-1}h[k]x[n-k]$

The operation of the FIR filter in hardware consists of the following steps: After the microcontroller generates an interrupt from the ADC, the ADC value is output from the microcontroller, which is interconnected with the input pins of the FPGA. Subsequently, a bit indicating a write to the FPGA is set to 1 on a pin of the microcontroller, also interconnected to the FPGA, so that the input register of the FPGA design is written with the ADC conversion value. The write bit, which is an input to the hardware design, is also used to propagate as a clock signal to the other registers. This causes, at the moment the ADC value is read by the FIR filter module, the other values to shift to the next register, thus updating each register for the new sample $x_n$. Due to the short propagation time, the result $y_n$ is immediately present at the FPGA output, which is then written to the microcontroller input port. The microcontroller reads this value and writes it to the DAC for output.

It is observed that no additional time is required other than the maximum signal propagation time in the FPGA, which is negligible since it is a synchronous circuit. Additionally, to save input and output pins, both ports, from the microcontroller and the FPGA, are used bidirectionally, performing the necessary process on each so that when one writes, the other reads and vice versa. Thus, when the microcontroller writes to the FPGA by setting the bit defined as $wr_e$ to 1, and due to the short response time, it proceeds to change its pins to input mode, set the bit to 0, and enable the bit defined as $rd_e$ to the FPGA by setting it to 1. This causes the FPGA input port to now act as an output, showing the result at the microcontroller input, and the microcontroller reads the value.

In the implementation of the FIR filter in the FPGA, the lower cutoff frequency is also 240 Hz, allowing the signal to pass without amplitude attenuation. Additionally, due to the way the signal is sent and filtered almost immediately, the phase delay in the signal is minimal. As observed in the following Figure, the phase delay time is nearly 100 µs.

<img width="1669" height="901" alt="H240" src="https://github.com/user-attachments/assets/6b369490-f5e5-40d3-8af9-8d717a7acff4" />


At 450 Hz, the signal's phase delay is only 1.5 ms, and the signal has not yet been attenuated, as shown:

<img width="1666" height="871" alt="H450" src="https://github.com/user-attachments/assets/3a71e258-8e03-49cb-a128-9d49e409b42a" />


Finally, as shown below, the signal at 500 Hz is attenuated again, indicating that the performance in the upper cutoff band is appropriate.

<img width="1666" height="867" alt="H500" src="https://github.com/user-attachments/assets/9ec60dfd-1a56-4461-8c30-590a5c23aef7" />

