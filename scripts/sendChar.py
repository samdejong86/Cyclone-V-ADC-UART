#!/usr/bin/env python  

import serial
import argparse

parser = argparse.ArgumentParser(description='Send a character to the FPGA via UART')
parser.add_argument('-c','--char', help='character to send', default="c", required=False)
parser.add_argument('-p','--port', help='The port to listen to', default="/dev/ttyUSB0", required=False)

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



message=args.char 
set_ser.write(message.encode('utf-8'))

set_ser.close()
