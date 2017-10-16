#!/home/srdejong/miniconda3/bin/python

"""
Creates an animation of the waveform send from the FPGA. 

Based on:
Matplotlib Animation Example

author: Jake Vanderplas
email: vanderplas@astro.washington.edu
website: http://jakevdp.github.com
license: BSD
Please feel free to use and modify this, but keep the above information. Thanks!
"""

import numpy as np
import serial   
from matplotlib import pyplot as plt
from matplotlib import animation

#method to read ATLASCalib.dat
def Read_Two_Column_File(file_name):
    with open(file_name, 'r') as data:
        x = []
        y = []
        for line in data:
            p = line.split()
            x.append(float(p[0]))
            y.append(float(p[1]))

    return x, y
   
#read the ATLAS pulse from the file
x_pulse, y_pulse = Read_Two_Column_File('ATLASCalib.dat')


#set the serial port settings
set_ser = serial.Serial()
set_ser.port="/dev/ttyUSB1"          #the location of the USB port 
set_ser.baudrate=1000000             #baud rate of 1MHz
set_ser.parity = serial.PARITY_NONE
set_ser.stopbits=serial.STOPBITS_ONE
set_ser.bytesize = serial.EIGHTBITS
set_ser.timeout=0.002

#open the serial port
set_ser.open()

# First set up the figure, the axis, and the plot element we want to animate
fig = plt.figure()
ax = plt.axes(xlim=(0, 800), ylim=(8000, 8800))



plotlays, plotcols = [2], ["black","red"]
lines = []
for index in range(2):
    lobj = ax.plot([],[],lw=2,color=plotcols[index])[0]
    lines.append(lobj)


# initialization function: plot the background of each frame
def init():
    for line in lines:
        line.set_data([],[])
    return lines

x,y = [],[]

# animation function.  This is called sequentially
def animate(i):
    message="d" 
    set_ser.write(message.encode('utf-8'))
    data=set_ser.read(1000)

    n=0
    lastC=0
    ADC=0
    x=[]
    y=[]
    
    #loop over response. response looks like:
    # xyz
    # where xy is the ADC counts, z is the time.

    for c in data:
        if n%3==0:
            lastC=c<<8  #bit shift 'x' by 8
        elif n%3==1:
            ADC=lastC+c #add bit shifted x to y
        elif n%3==2:
            x.append(c*25) 
            y.append(ADC)
        n=n+1
    
    peakLoc=y.index(max(y))  #index of maximum
    maximum=y[peakLoc];      #value of maximum
    pedistal = (y[0]+y[1]+y[3]+y[4])/4 #pedistal
    
    mx=float(maximum-pedistal)/0.906592
       
    #plot the ATLAS pulse from ATLASCalib.dat, adjusted to the same max and pedistal value as the data from the FPGA
    x2=np.add(np.divide(x_pulse,1e-9),x[peakLoc]-73.81072) 
    y2=np.add(np.multiply(y_pulse, mx), pedistal)

    
    lines[0].set_data(x2,y2)
    lines[1].set_data(x,y)

       

    return lines

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=800, interval=20, blit=True)



plt.xlabel("Time (ns)")
plt.ylabel("ADC counts (AU)")
plt.show()

set_ser.close()
