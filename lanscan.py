#! /usr/bin/python
########################################################################
# Scans the lan for pcs, prints thier ip and hostname.
# Copyright (C) 2014  Carl J Smith
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
########################################################################
import sys, socket
# code below figures out network prefix, then searches lan using ip address range,
# if found return the hostname into a array, if more than 12 failures occur in a row
# you have probably found all hosts and break the loop
socket.setdefaulttimeout(0.1)
prefix = ('.'.join(socket.gethostbyname(socket.gethostname()+'.local').split('.')[:3]))+'.'
print 'Scanning network using prefix:',prefix
hostnames = []
failureThreshold = 255
failures = 0	
for ip in range(255):
	# create clean tempIP var
	tempIP=''
	# set tempIP to store the ip being scanned
	tempIP=(prefix+str(ip))
	# display scanning info to user
	sys.stdout.write('Scanning: '+(tempIP)+(' '*10)+'\r')
	sys.stdout.flush()
	# use this so that a failed ping does not crash the program
	try:
		# query the hostname for the ip address above
		tempHOST=(socket.gethostbyaddr(tempIP))
		# remove the .local part of the address 
		tempHOST=tempHOST[0].split('.')[0]
		# print out the ip and hostname to the user of pc if any is found
		print ((tempIP)+ ' ' + tempHOST +(' '*10))
		#sys.stdout.write((tempIP)+ ' ' + tempHOST +(' '*10)+'\n')
		failures = 0
	except:
		#~ sys.stdout.write('Failed: '+(prefix+str(ip))+'\r')
		#~ sys.stdout.flush()
		failures += 1
		# so the user can see whats up
		#~ sleep(0.2)
	if failures >= failureThreshold:
		# if there are 30 or more failures break search since they shouldnt be that
		# far apart in the addressing
		print ' '*60
		print 'Scan Complete!'
		exit()
print 'Scan Complete!'
