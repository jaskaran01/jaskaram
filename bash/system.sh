#!/bin/bash
#bash shell assignment

function systemname ()
{
    echo ""
    echo "The system name is $(hostname -s)"
    return 0
}
 
function domainname ()
{
    echo ""
    if [ -n $(hostname -d)];
    then  
    echo "My computer is attached to $(hostname -d) domain"  
    else  
    echo "My computer is not part of any domain"  
    fi
    return 0
}

function ipaddr ()
{
	ipaddrs=$(hostname -I)
	if [[ $? -ne 0 ]];then
		shellout 'Failed to find IP Addresses'
	fi
	ipaddrs=$(echo $ipaddrs|sed 's/ /,/g')
	echo "IP Adresses Of Host : $ipaddrs"
	return 0
}

function osver ()
{
    echo ""
    if [ -n $(ls /etc/os-release ) ]
    then
    echo "The Operating system version of this machine is  $(cat /etc/os-release | grep "VERSION_ID"| cut -d\" -f2)"
    return 0
    else
    echo "To run this command system must have /etc/os-release file" >&2
    exit 0
    fi
    return 0
}

function osname () 
{
    echo ""
    if [ -n $(ls /etc/os-release ) ]
    then
    echo "Operating system name of the machine is $(cat /etc/os-release | grep "NAME" | head -n1 | cut -d\" -f2)"
    return 0
    else
    echo "To run this command computer must have /etc/os-release file" >&2
    exit 0
    fi
    return 0
 }

function CPUdescription ()
{
	echo "CPU description : "$(cat /proc/cpuinfo|grep 'model name'|head -n 1|cut -d\: -f2|sed 's/^ //')
	return 0
}

function meminstalled ()
{	
	totalm=$(free -m -h| awk '/^Mem:/{print $2}')
	echo "memory installed : $totalm"
	return 0
}

function avdiskspace ()
{
	echo "available diskspace : "$(df -Ph . | tail -1 | awk '{print $4}')
	return 0
}

function printers ()
{
{
	#Check if the cups service is installed
	if [ -z $(dpkg -l | grep "^ii" | awk '{print $2}' | grep "^cups" | sort -n | head -1) ]
	then
		echo "Cups is not installed" >&2
	else
		service cups status > /dev/null 2>&1
		if [ $? -eq 3 ]
		then
			echo "Cups is not running" >&2
			echo "Cups must be started to run this option" >&2
		else
			lpstat -a > /dev/null 2>&1
			if [ $? -eq 0 ]
			then
				echo "Available Printers : "
				echo $(lpstat -a | awk '{print $1}')
			else
				echo "This machine has no printer" >&2
			fi
		fi
	fi
}
    return 0
}

function installedsoftware ()
{
    {
	echo "Installed Software : "
	dpkg -l|grep ^ii|cut -d' ' -f3
    }
    return 0
}
function error ()
{
    opt=($(echo $@ | cut -d\- -f2 | sed -r 's/(.)(.)/\1 \2 /g'))
    if [ -z $@ ]
    then
	#Display All  info In case of no Argument Passed
	systemname
    domainname
    ipaddr
    osver
    osname
    CPUdescription
    meminstalled
    avdiskspace
    printers
    installedsoftware
else
	count=0
	while [ $count -lt ${#opt[@]} ]; do
	  case ${opt[$count]} in
	  	s )
			count_s=$((count_s+1))
			if [[ $count_s -gt 1 ]];then
				# To Skip Multiple calls When same option passed multiple times
				continue
			fi
	  		systemname 
			;;
		d )
			count_d=$((count_d+1))
			if [[ $count_d -gt 1 ]];then
				continue
			fi
			domainname
			;;
		i )
			count_i=$((count_i+1))
			if [[ $count_i -gt 1 ]];then
				continue
			fi
			ipaddr
			;;
	
		o ) 
			count_o=$((count_o+1))
			if [[ $count_o -gt 1 ]];then
				continue
			fi
			osver
			;;
		n )
			count_n=$((count_n+1))
			if [[ $count_n -gt 1 ]];then
				continue
			fi
			osname
			;;
		c )
			count_c=$((count_c+1))
			if [[ $count_c -gt 1 ]];then
				continue
			fi
			CPUdescription
			;;
		m )
			count_m=$((count_m+1))
			if [[ $count_m -gt 1 ]];then
				continue
			fi
			meminstalled
			;;		
		a )
			count_a=$((count_a+1))
			if [[ $count_a -gt 1 ]];then
				continue
			fi
			avdiskspace
			;;	
		p )
			count_p=$((count_p+1))
			if [[ $count_p -gt 1 ]];then
				continue
			fi
			printers
			;;
		t )
			count_t=$((count_t+1))
			if [[ $count_t -gt 1 ]];then
				continue
			fi
			installedsoftware
			;;		
	    h )
	      echo "Usage:"
	      echo "bash system.sh -h 	Display this help message."
	      echo " 	-sn 		Display the System Name"
	      echo "	-dn 		Display the Domain Name"
	      echo "	-ipa 		Display the IP Addresses"
	      echo "	-os 		Display the OS VERSION"
	      echo " 	-ns 		Display the OS NAME"
	      echo " 	-cpu 		Display the CPU Description"
	      echo " 	-mi 		Display the Memory Installed"
	      echo " 	-ads 		Display the Available Disk Space"
	      echo " 	-pr 		Display the List of Printers"
	      echo " 	-inst 		Display the Installed Software"
	      echo "Example  bash system.sh -simpads"
	      shellout     
	      ;;
	    * )
	      shellout "Invalid Option: -${opt[$count]}" 1>&2
	      ;;
	esac
	count=$((count+1))
	done
	#shift $((OPTIND -1))
	fi
}
