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
	      echo "bash script.sh -h 	Display this help message."
	      echo " 	-sn 		Display System Name"
	      echo "	-dn 		Display Domain Name"
	      echo "	-ipa 		Display IP Addresses of Host"
	      echo "	-os 		Display OS VERSION"
	      echo " 	-ns 		Display OS NAME"
	      echo " 	-cpu 		Display CPU Description"
	      echo " 	-mi 		Display Memory Installed"
	      echo " 	-ads 		Display Available Disk Space"
	      echo " 	-pr 		Display List of Printers"
	      echo " 	-inst 		Display Installed Software"
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
    return 0
}