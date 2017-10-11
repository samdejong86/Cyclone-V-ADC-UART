#!/home/srdejong/miniconda3/bin/python

import serial
import matplotlib.pyplot as plt

set_ser = serial.Serial()
set_ser.port="/dev/ttyUSB1"
set_ser.baudrate=1000000
set_ser.parity = serial.PARITY_NONE
set_ser.stopbits=serial.STOPBITS_ONE
set_ser.bytesize = serial.EIGHTBITS
set_ser.timeout=1


set_ser.open()

message="ds"
set_ser.write(message.encode('utf-8'))
line=set_ser.read(5000)

i=0
lastC=0
ADC=0
xx=[]
yy=[]

for c in line:
    #print(c)
    if i%3==0:
        lastC=c<<8
    elif i%3==1:
        ADC=lastC+c
    elif i%3==2:
        xx.append((c-32)*25)
        yy.append(ADC)
    i=i+1
    
set_ser.close()

plt.xlabel("Time (ns)")
plt.ylabel("ADC counts (AU)")

plt.plot(xx, yy)
plt.show()
