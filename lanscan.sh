#! /bin/bash
########################################################################
# Scans connected networks for local computers and list IPs and hostnames
# Copyright (C) 2017  Carl J Smith
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
showHelp(){
	# print help message and exit if the user uses the help argument
	echo "################################################################################"
	echo "# Scans connected networks for local computers and list IPs and hostnames"
	echo "# Copyright (C) 2017  Carl J Smith"
	echo "#"
	echo "# This program is free software: you can redistribute it and/or modify"
	echo "# it under the terms of the GNU General Public License as published by"
	echo "# the Free Software Foundation, either version 3 of the License, or"
	echo "# (at your option) any later version."
	echo "#"
	echo "# This program is distributed in the hope that it will be useful,"
	echo "# but WITHOUT ANY WARRANTY; without even the implied warranty of"
	echo "# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
	echo "# GNU General Public License for more details."
	echo "#"
	echo "# You should have received a copy of the GNU General Public License"
	echo "# along with this program.  If not, see <http://www.gnu.org/licenses/>."
	echo "################################################################################"
	echo "Lanscan will scan all connected subnets for active hosts and attempt to resolve"
	echo "the hostname of those hosts."
	echo "################################################################################"
	echo "-h or --help"
	echo "    Display this help message"
	echo "################################################################################"
}
# -h will detect -h and --help arguments
if echo "$@" | grep -q -e "-h";then
	showHelp
else
	################################################################################
	# by default the system will scan all subnets for connected computers with nmap
	################################################################################
	# find all the subnets connected to the computer
	# - ignore 127 localhost loopback interfaces
	foundSubnets=$(ifconfig | grep inet | sed "s/inet //g" | grep -v inet6 | tr -d ' ' | sed "s/netmask.*$//g" | grep ".*\..*\..*\." -o | grep -v "127.0.0")
	# for each subnet scan that subnet with nmap
	for subnet in $foundSubnets;do
		# display the header
		echo "# Searching IP range \"$subnet*\" #" | sed "s/./#/g"
		echo "# Searching IP range \"$subnet*\" #"
		echo "# Searching IP range \"$subnet*\" #" | sed "s/./#/g"
		# search each subnet
		nmap -sP "$subnet*" | grep report | sed "s/Nmap scan report for //g" | sed "s/[()]//g" | column -t
	done
fi
