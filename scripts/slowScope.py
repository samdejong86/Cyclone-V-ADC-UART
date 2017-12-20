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
import argparse

parser = argparse.ArgumentParser(description='View waveforms coming from UART')
parser.add_argument('-p','--port', help='The port to listen to', default="/dev/ttyUSB0", required=False)
parser.add_argument('-m','--movie', help='Save a 200 frame video', action='store_true', required=False)
parser.add_argument('-f','--filename', help='Video filename', default="slowScope.mp4", required=False)
parser.add_argument('-t','--timeout', help='Port timeout (controls update rate)', default=0.02, required=False)

args = parser.parse_args()



#set the serial port settings
set_ser = serial.Serial()
set_ser.port=args.port          #the location of the USB port 
set_ser.baudrate=1000000             #baud rate of 1MHz
set_ser.parity = serial.PARITY_NONE
set_ser.stopbits=serial.STOPBITS_ONE
set_ser.bytesize = serial.EIGHTBITS
set_ser.timeout=float(args.timeout)

#open the serial port
set_ser.open()

# First set up the figure, the axis, and the plot element we want to animate
fig = plt.figure()
ax = plt.axes(xlim=(0, 10000), ylim=(000, 16000))
#line=ax.plot([],[],lw=2, marker='',color='black')[0]
line, = ax.plot([], [], 'r-', animated=True)


# initialization function: plot the background of each frame
def init():
    line.set_data([],[])
    return line,

x,y = [],[]

# animation function.  This is called sequentially
def animate(i):
    message="d" 
    set_ser.write(message.encode('utf-8'))
    data=set_ser.read(1500)

    #print(len(data))


    x=[]
    y=[]

    
    #loop over response. response looks like:
    # xyz
    # where xy is the ADC counts, z is the time.
    
    for i in range(499):
        x.append(i/0.050)
        y.append((data[3*i]<<8)+data[3*i+1])

           

    line.set_data(x,y)       


    return line,

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=200, interval=20, blit=True)

if args.movie:
    anim.save(args.filename, metadata={'artist':'Sam'})

plt.xlabel("Time (ns)")
plt.ylabel("ADC counts (AU)")
plt.show()

set_ser.close()


