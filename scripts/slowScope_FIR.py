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
import matplotlib.patches as mpatches

import argparse

parser = argparse.ArgumentParser(description='View waveforms coming from UART')
parser.add_argument('-p','--port', help='The port to listen to', default="/dev/ttyUSB0", required=False)
parser.add_argument('-m','--movie', help='Save a 200 frame video', action='store_true', required=False)
parser.add_argument('-f','--filename', help='Video filename', default="slowScope.mp4", required=False)
parser.add_argument('-t','--timeout', help='Port timeout (controls update rate)', default=0.02, required=False)
parser.add_argument('-r','--freq'   , help='Sampling frequency in Megahertz',     default=50, required=False)

args = parser.parse_args()

x=[]
y=[]
f=[]



#set the serial port settings
set_ser = serial.Serial()
set_ser.port=args.port          #the location of the USB port 
set_ser.baudrate=1000000             #baud rate of 1MHz
set_ser.parity = serial.PARITY_NONE
set_ser.stopbits=serial.STOPBITS_ONE
set_ser.bytesize = serial.EIGHTBITS
set_ser.timeout=float(args.timeout)

sampleFreq=float(args.freq)/1000


#open the serial port
set_ser.open()

# First set up the figure, the axis, and the plot element we want to animate
fig = plt.figure()
ax = plt.axes(xlim=(0, 500/sampleFreq), ylim=(-8000, 8000))
#line=ax.plot([],[],lw=2, marker='',color='black')[0]
lines = []

lobj = ax.plot([], [], 'r-', animated=True)[0]
lobj2 = ax.plot([], [], 'b-', animated=True)[0]
wNum_text = ax.text(0.02, 0.95, '', transform=ax.transAxes)

lines.append(lobj)
lines.append(lobj2)
lines.append(wNum_text)

# initialization function: plot the background of each frame
def init():
    for i in range(2):
        lines[i].set_data([],[])
    lines[2].set_text(" ")
    return lines

waveNumber=0

# animation function.  This is called sequentially
def animate(i):
    message="i" 
    set_ser.write(message.encode('utf-8'))
    data=set_ser.read(3200)

    global waveNumber
    global sampleFreq
    
    if len(data)!=0:


        del x[:]
        del y[:]
        del f[:]


        #loop over response. response looks like:
        # xyz
        # where xy is the ADC counts, z is the time.
    
        for i in range(499):
            x.append(i/sampleFreq)
            y.append((data[3*i]<<8)+data[3*i+1]-8192)
            f.append((data[3*(i+500)]<<8)+data[3*(i+500)+1]-8192)

        waveNumber = (data[3000]<<8)+data[3001]

       
    lines[0].set_data(x,y) 
    lines[1].set_data(x,f)       
    lines[2].set_text("wave number: "+str(waveNumber))
    



    return lines

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=200, interval=20, blit=True)

if args.movie:
    anim.save(args.filename, metadata={'artist':'Sam'})

plt.xlabel("Time (ns)")
plt.ylabel("ADC counts (AU)")
red_patch = mpatches.Patch(color='red', label='Signal')
blue_patch = mpatches.Patch(color='blue', label='FIR')
plt.legend(handles=[red_patch, blue_patch])


plt.show()

set_ser.close()


