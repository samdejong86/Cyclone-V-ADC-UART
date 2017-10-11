#!/home/srdejong/miniconda3/bin/python

import serial
import matplotlib.pyplot as plt

#set the serial port settings
set_ser = serial.Serial()
set_ser.port="/dev/ttyUSB1" 
set_ser.baudrate=1000000 
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
line=set_ser.read(5000)

i=0
lastC=0
ADC=0
xx=[]
yy=[]

#loop over response. response looks like:
# xyz
# where xy is the ADC counts, z is the time.

for c in line:
    if i%3==0:        
        lastC=c<<8  #bit shift 'x' by 8
    elif i%3==1:
        ADC=lastC+c #add bit shifted x to y
    elif i%3==2:
        xx.append(c*25) 
        yy.append(ADC)
        print(str(c)+" "+str(ADC))
    i=i+1
    
#close serial port
set_ser.close()


plt.xlabel("Time (ns)")
plt.ylabel("ADC counts (AU)")

#plot ADC counts vs time
plt.plot(xx, yy)
plt.show()
