#!/usr/bin/env python  

import serial
import matplotlib.pyplot as plt
import numpy as np
import argparse
import re

defaultRate=50

try:
    for line in open("../lpm_pll.v"):
        if "gui_output_clock_frequency0" in line:
            result = re.search('%s(.*)%s' % ("value=\"", "\" />"), line).group(1)
            defaultRate=float(result)
except FileNotFoundError:
    defaultRate=50

parser = argparse.ArgumentParser(description='View a single waveform coming from UART')
parser.add_argument('-p','--port', help='The port to listen to', default="/dev/ttyUSB0", required=False)
parser.add_argument('-s','--save', help='Save data to a file', action='store_true', required=False)
parser.add_argument('-f','--filename', help='Name of data file', default="UART_FIR.dat", required=False)
parser.add_argument('-n','--noGraph', help='Suppress graphical output', action='store_true', required=False)
parser.add_argument('-r','--freq'   , help='Sampling frequency in Megahertz (default: %(default)s)',     default=defaultRate, required=False)

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

data=[]

i=0
lastC=0
ADC=0
xx=[]
yy=[]
ff=[]

fpgaPulseHeight=0
Pedistal=0
wavenum=0

#print(len(data))
while len(data) == 0:

        #send a message (can be anything)
	message="i" 
	set_ser.write(message.encode('utf-8'))

	#recieve a response
	data=set_ser.read(3600)

	if len(data)==0:
		continue;
	
        #loop over response. response looks like:
        # xyz
        # where xy is the ADC counts, z is the time.
	for i in range(499):
		xx.append(i/(float(args.freq)/1000))
		yy.append((data[3*i]<<8)+data[3*i+1]-8192)
		ff.append((data[3*(i+500)]<<8)+data[3*(i+500)+1]-8192)

	waveNum = (data[3000]<<8)+data[3001]



#close serial port
set_ser.close()

if args.save:
    with open(args.filename, 'w') as f:
	    f.write(str(waveNum)+"\n")
	    for i in range(len(xx)):
		    f.write(str(xx[i]) + "\t" + str(yy[i]) + "\t" + str(ff[i])+"\n")


if not args.noGraph:

    plt.xlabel("Time (ns)")
    plt.ylabel("ADC counts (AU)")
    
    #plot ADC counts vs time
    plt.plot(xx, yy)
    plt.plot(xx, ff)
plt.show()
