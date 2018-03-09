#!/usr/bin/env python  
"""
=================
Animated subplots
=================

This example uses subclassing, but there is no reason that the proper function
couldn't be set up and then use FuncAnimation. The code is long, but not
really complex. The length is due solely to the fact that there are a total of
9 lines that need to be changed for the animation as well as 3 subplots that
need initial set up.

"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
import matplotlib.animation as animation

import serial   
from matplotlib import pyplot as plt
import argparse
import scipy.optimize
import re

defaultRate=50

try:
    for line in open("../lpm_pll.v"):
        if "gui_output_clock_frequency0" in line:
            result = re.search('%s(.*)%s' % ("value=\"", "\" />"), line).group(1)
            defaultRate=float(result)
except FileNotFoundError:
    defaultRate=50

parser = argparse.ArgumentParser(description='Find amplitude and phase of sinewave from FPGA')
parser.add_argument('-p','--port', help='The port to listen to', default="/dev/ttyUSB0", required=False)
parser.add_argument('-m','--movie', help='Save a video', action='store_true', required=False)
parser.add_argument('-f','--filename', help='Video filename', default="Amplitude_Phase_Scan.mp4", required=False)
parser.add_argument('-t','--timeout', help='Port timeout (controls update rate)', default=0.2, required=False)
parser.add_argument('-r','--freq'   , help='Sampling frequency in Megahertz (default: %(default)s)',     default=defaultRate, required=False)
parser.add_argument('-d','--delay', help='Send delay signal before starting, resend after', action='store_true', required=False)

args = parser.parse_args()





def fit_sin(tt, yy):
    '''Fit sin to the input time sequence, and return fitting parameters "amp", "omega", "phase", "offset", "freq", "period" and "fitfunc"'''
    tt = np.array(tt)
    yy = np.array(yy)
    ff = np.fft.fftfreq(len(tt), (tt[1]-tt[0]))   # assume uniform spacing
    Fyy = abs(np.fft.fft(yy))
    guess_freq = abs(ff[np.argmax(Fyy[1:])+1])   # excluding the zero frequency "peak", which is related to offset
    guess_offset = 8192
    guess_amp = max(yy)-guess_offset
    guess = np.array([2.*np.pi*guess_freq, -1.7])

    b=([0.1*guess_freq,-np.inf], [100*guess_freq,np.inf])
    

    def sinfunc(t, w, p):  return   guess_amp*np.sin(w*t + p) + guess_offset
    popt, pcov = scipy.optimize.curve_fit(sinfunc, tt, yy, p0=guess,bounds=b )
    w,p=popt
    f = w/(2.*np.pi)
    fitfunc = lambda t: A * np.sin(w*t + p) + c
    return {"amp": guess_amp, "omega": w, "phase": p, "offset": guess_offset, "freq": f, "period": 1./f, "fitfunc": fitfunc, "maxcov": np.max(pcov), "rawres": (guess,popt,pcov)}

#set the serial port settings
set_ser = serial.Serial()
set_ser.port=args.port          #the location of the USB port 
set_ser.baudrate=1000000             #baud rate of 1MHz
set_ser.parity = serial.PARITY_NONE
set_ser.stopbits=serial.STOPBITS_ONE
set_ser.bytesize = serial.EIGHTBITS
set_ser.timeout=float(args.timeout)

set_ser.open()


if args.delay:
    print("Sending delay signal")
    message="d" 
    set_ser.write(message.encode('utf-8'))



class SubplotAnimation(animation.TimedAnimation):
    def __init__(self):
        fig = plt.figure(figsize=(12,10))
        ax1 = fig.add_subplot(2, 2, 1)
        ax2 = fig.add_subplot(2, 2, 2)
        ax3 = fig.add_subplot(2, 1, 2)
        ax1.set_xscale('log')
        ax2.set_xscale('log')


        self.t = np.linspace(0, 80, 19999)
        self.x = []
        self.y = []
        self.freq =[]
        self.phase=[]
        self.amp=[]
        self.sampleFreq=float(args.freq)/1000

        ax1.set_xlabel('Frequency (kHz)')
        ax1.set_ylabel('Amplitude (ADC counts)')
        self.line1 = Line2D([], [], marker='o',linestyle=' ',ms=0.2,color='black')
        self.line1a = Line2D([], [], color='red', linewidth=1)
        self.line1e = Line2D(
            [], [], color='red', marker='o', markeredgecolor='r')
        ax1.add_line(self.line1)
        ax1.add_line(self.line1a)
        ax1.add_line(self.line1e)
        ax1.set_xlim(50, 10000)
        ax1.set_ylim(1000,5000)

        ax2.set_xlabel('Frequency (kHz)')
        ax2.set_ylabel('Phase (rad)')
        self.line2 = Line2D([], [],marker='o',linestyle=' ',ms=0.2, color='black')
        self.line2a = Line2D([], [], color='red', linewidth=1)
        self.line2e = Line2D(
            [], [], color='red', marker='o', markeredgecolor='r')
        ax2.add_line(self.line2)
        ax2.add_line(self.line2a)
        ax2.add_line(self.line2e)
        ax2.set_xlim(50, 10000)
        ax2.set_ylim(-2*3.14, 2*3.14)

        ax3.set_xlabel('Time (ns)')
        ax3.set_ylabel('ADC counts')
        self.line3 = Line2D([], [], color='black')
        ax3.add_line(self.line3)
        ax3.set_xlim(0, 1000/self.sampleFreq)
        ax3.set_ylim(0, 16000)

        animation.TimedAnimation.__init__(self, fig, interval=10, blit=True)

    def _draw_frame(self, framedata):
        i = framedata
        head = i - 1
        
        message="w" 
        set_ser.write(message.encode('utf-8'))
        data=set_ser.read(3700)

        if len(data)!=0:


            self.x=[]
            self.y=[]


            #loop over response. response looks like:
            # xyz
            # where xy is the ADC counts, z is the time.
    
            for k in range(999):
                self.x.append(k/self.sampleFreq)
                self.y.append((data[3*k]<<8)+data[3*k+1])
                
     
            try:
                fit=fit_sin(self.x[:500],self.y[:500])
            except RuntimeError:
                print("runtime error")
                return


            if fit['maxcov']<0.001:
               
                self.freq.append(fit['freq']*1000000)
                self.amp.append(fit['amp'])
                self.phase.append(fit['phase'])
        

    
        self.line1.set_data(self.freq, self.amp)
        self.line1e.set_data(self.freq[-1:], self.amp[-1:])
        self.line1a.set_data(self.freq[-5:], self.amp[-5:])

        self.line2.set_data(self.freq, self.phase)
        self.line2e.set_data(self.freq[-1:], self.phase[-1:])
        self.line2a.set_data(self.freq[-5:], self.phase[-5:])

        self.line3.set_data(self.x,self.y)

        self._drawn_artists = [self.line1, self.line1a, self.line1e,
                               self.line2, self.line2a, self.line2e,
                               self.line3]

    def new_frame_seq(self):
        return iter(range(self.t.size))

    def _init_draw(self):
        lines = [self.line1, self.line1a, self.line1e,
                 self.line2, self.line2a, self.line2e,
                 self.line3]#, self.line3a, self.line3e]
        for l in lines:
            l.set_data([], [])

ani = SubplotAnimation()


if args.movie:
    ani.save(args.filename, metadata={'artist':'Sam'})

plt.show()


if args.delay:
    print("Sending delay signal")
    message="d" 
    set_ser.write(message.encode('utf-8'))


set_ser.close()
