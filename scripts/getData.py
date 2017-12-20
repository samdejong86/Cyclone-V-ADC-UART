#!/home/srdejong/miniconda3/bin/python

import serial
import matplotlib.pyplot as plt
import numpy as np
import argparse

parser = argparse.ArgumentParser(description='View a single waveform coming from UART')
parser.add_argument('-p','--port', help='The port to listen to', default="/dev/ttyUSB0", required=False)
parser.add_argument('-s','--save', help='Save data to a file', action='store_true', required=False)
parser.add_argument('-f','--filename', help='Name of data file', default="UART.dat", required=False)
parser.add_argument('-n','--noGraph', help='Suppress graphical output', action='store_true', required=False)

args = parser.parse_args()

#set the serial port settings
set_ser = serial.Serial()
set_ser.port=args.port          #the location of the USB port 
set_ser.baudrate=1000000             #baud rate of 1MHz
set_ser.parity = serial.PARITY_NONE
set_ser.stopbits=serial.STOPBITS_ONE
set_ser.bytesize = serial.EIGHTBITS
set_ser.timeout=1

#open the serial port
set_ser.open()

#send a message (can be anything)
message="d" 
set_ser.write(message.encode('utf-8'))

#recieve a response
data=set_ser.read(1500)


i=0
lastC=0
ADC=0
xx=[]
yy=[]

#loop over response. response looks like:
# xyz
# where xy is the ADC counts, z is the time.

fpgaPulseHeight=0
Pedistal=0

for i in range(499):
        xx.append(i/0.05)
        yy.append((data[3*i]<<8)+data[3*i+1])



#close serial port
set_ser.close()

if args.save:
    with open(args.filename, 'w') as f:
        for i in range(len(xx)):
            f.write(str(xx[i]) + "\t" + str(yy[i]) + "\n")


if not args.noGraph:

    plt.xlabel("Time (ns)")
    plt.ylabel("ADC counts (AU)")
    
    #plot ADC counts vs time
    plt.plot(xx, yy)
plt.show()
