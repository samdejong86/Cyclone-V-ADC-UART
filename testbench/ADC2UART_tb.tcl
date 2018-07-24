transcript off

#vmap uart_pll rtl_work
#vmap lpm_pll rtl_work
#vmap fir_ofc rtl_work

onerror {resume}
WaveActivateNextPane {} 0
delete wave *

add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000  -position end  sim:/adc2uart_tb/testbench/ADC_DB
add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000 -position end  sim:/adc2uart_tb/testbench/ADC_handle/ADC_B


proc signalOff {} {
     force -freeze sim:/adc2uart_tb/ADC_DB 2#10000000000000 0
     force -freeze sim:/adc2uart_tb/ADC_DA 2#10000000000000 0
}

proc signalOn {} {
     noforce sim:/adc2uart_tb/ADC_DB
     noforce sim:/adc2uart_tb/ADC_DA
}


proc TRIGsim {} {
     delete wave *
     restart -f

     add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000  -position end  sim:/adc2uart_tb/testbench/ADC_DB
     add wave -radix unsigned -format analog-step -height 60 -max 16383 -min 0  -position end  sim:/adc2uart_tb/testbench/ADC_DA
     add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000 -position end  sim:/adc2uart_tb/testbench/ADC_handle/ADC_B
     add wave -radix unsigned -format analog-step -height 60 -max 16383 -min 0 -position end  sim:/adc2uart_tb/testbench/ADC_handle/ADC_A
     add wave -radix unsigned -format analog-step -height 60 -max 16383 -min 0  -position end  sim:/adc2uart_tb/testbench/ADC_handle/triggerBus     

     add wave -position end  sim:/adc2uart_tb/testbench/trigSlope
     add wave -position end  sim:/adc2uart_tb/testbench/trigSource

     add wave -position end  sim:/adc2uart_tb/testbench/ADC_handle/trigger

     add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/UART_RX
     add wave -radix ASCII  -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/char

     add wave -radix unsigned -position end  sim:/adc2uart_tb/testbench/ADC_handle/triggerLevel

     #01110011 : s
     #01110100 : t
     
     force -deposit sim:/adc2uart_tb/UARTcounter 99 25us
     # set to 's'
     force -deposit sim:/adc2uart_tb/charToSend 2#01110011 25us   


     force -deposit sim:/adc2uart_tb/UARTcounter 99 50us
     # set to 't'
     force -deposit sim:/adc2uart_tb/charToSend 2#01110100 50us   


     force -deposit sim:/adc2uart_tb/UARTcounter 99 75us
     # set to 's'
     force -deposit sim:/adc2uart_tb/charToSend 2#01110011 75us  
     


     run 110us
     wave zoom full


}


proc sendChar {CHAR} {

      #convert char to hex	
     set c  [format %2.2X [scan $CHAR %c]]   

     #convert hex to binary
     binary scan [binary format H* $c] B* bits

     force -deposit sim:/adc2uart_tb/UARTcounter 90 0us
     force -freeze sim:/adc2uart_tb/charToSend 2#$bits 0us

     echo $CHAR
     echo $c
     echo $bits

     run 30us	

}


proc UARTsim {{CHAR w} {DURATION 250000ns}} {

     delete wave *
     restart -f


     #force -freeze sim:/adc2uart_tb/charToSend 01100100 10
     
     add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000 -position end  sim:/adc2uart_tb/testbench/ADC_DB
     add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000 -position end  sim:/adc2uart_tb/testbench/ADC_handle/ADC_B

     add wave -position end  sim:/adc2uart_tb/UART_RX

     add wave -position end  sim:/adc2uart_tb/testbench/trigSlope
     add wave -position end  sim:/adc2uart_tb/testbench/trigSlopeUART
     add wave -position end  sim:/adc2uart_tb/testbench/trigSource
     add wave -position end  sim:/adc2uart_tb/testbench/trigSourceUART
     add wave -position end  sim:/adc2uart_tb/testbench/delay
     add wave -position end  sim:/adc2uart_tb/testbench/delayUART

     add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/acq
     add wave -position end  sim:/adc2uart_tb/testbench/acquire

     add wave -radix ASCII -position end  sim:/adc2uart_tb/testbench/UART_handle/readChar/char
     add wave -radix unsigned -position end  sim:/adc2uart_tb/testbench/ADC_handle/waveform
     add wave -radix unsigned -position end  sim:/adc2uart_tb/testbench/ADC_handle/waveNumber
     add wave -position end  sim:/adc2uart_tb/UART_TX
     add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/signalOut/waveSample
     add wave -position end  sim:/adc2uart_tb/testbench/UART_handle/signalOut/waveformCounter
     add wave -position end -radix ASCII sim:/adc2uart_tb/charToSend


     #convert char to hex
     set c  [format %2.2X [scan $CHAR %c]]   

     #convert hex to binart
     binary scan [binary format H* $c] B* bits  


     force -freeze sim:/adc2uart_tb/charToSend 2#$bits 10
     run $DURATION  
     echo $CHAR
     echo $c
     echo $bits
     wave zoom full

}


proc FIRsim { {DURATION 10000ns}} {

     delete wave *

     add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000 -position end  sim:/adc2uart_tb/testbench/ADC_DB
     add wave -radix unsigned -format analog-step -height 60 -max 15000 -min 7000 -position end  sim:/adc2uart_tb/testbench/ADC_handle/ADC_B

     add wave -radix decimal -format analog-step -height 60 -max 6000 -min -800 -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/fir_compiler_ii_0_avalon_streaming_sink_data

     add wave -radix decimal -format analog-step -height 60 -max 3500000000 -min -900000000  -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/FIR_filter/fir_compiler_ii_0_avalon_streaming_source_data

     add wave -radix unsigned -format analog-step -height 60 -max 16000 -min 6000  -position end  sim:/adc2uart_tb/testbench/ADC_handle/DSP_handle/unsignedFIR
     
     restart -f
     run $DURATION
     wave zoom full
}



run 25000 ns
wave zoom full

echo "Testbench for ADC2UART

run FIRsim to simulate the OFC FIR filter

run UARTsim CHAR DURATION to run the UART simulation
      CHAR is a character to send. Characters that should elicit a response:
      w - generate a waveform
      i - generate a waveform containing FIR data
      t - toggle the trigger source
      s - toggle the trigger slope
      d - toggle the delay
   DURATION is the duration of the run
      waveform takes 32000us to fully send

run sendChar CHAR to send a character on the UART_RX.

run TRIGsim to simulate triggering

run signalOff to set the ADC signals to baseline
run signalOn  to restore the ADC signals
"
