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
    echo " My computer is attached to $(hostname -d) domain"  
    else  
    echo " My computer is not part of any domain"  
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
    echo "To run this command system must have /etc/os-release file" >&2
    exit 0
    fi
    return 0
 }

function CPUdescription ()
{
    
 return 0
}

function meminstalled ()
{
return 0
}

function avdiskspace ()
{
return 0
}

function printers ()
{
return 0
}

function installedsoftware ()
{
return 0
}
