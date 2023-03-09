#!/bin/bash
# -------------------------------------------------------------------
# [Batuhan] IP-Scanner/Ping Tool
#        Scan IP ranges and get response, if the IP is already in use
#        or not.
# -------------------------------------------------------------------

# -- Option processing --
usage(){
	echo "Usage: $0 -i [Full IP adress] -b [.xxx] -e [.yyy] args"
	1>&2;
	exit 1;
}

while getopts "i:b:e:" optname;
do
    case "${optname}" in
        i)
            i=${OPTARG}
            ;;
        b)
            b=${OPTARG}
            ;;
        e)
	    e=${OPTARG}
            ;;
        *)
            echo "Invalid argument or unknown error while processing options"
            usage
            ;;
    esac
done

shift $((OPTIND - 1))

if [ -z "${i}" ] || [ -z "${b}" ] || [ -z "${e}" ]; then
	echo "PROBLEM!"
	usage
fi
	echo  "OK!"

# --- BODY LOGIC --------------------------------------------------------
#  SCRIPT LOGIC GOES HERE
echo "IP-Address  -i = ${i}"
echo "Start Value -b = ${b}"
echo "stop  value -e = ${e}"

rm -f $HOME/responded-ping-requests.txt
rm -f $HOME/non-responded-ping-requests.txt

for (( j = $b; j <= $e; j++ ))
do
	TARGET=$i$j
	
	ping -c1 $TARGET
	RETURN=$?
	
		if [ ${RETURN} -eq 0 ];
		then
			nslookup $TARGET | cut -d' ' -f 3 >> $HOME/responded-ping-requests-${i}.xxx.txt
			echo "${TARGET}" >> /home/t279/responded-ping-requests-${i}.xxx.txt
  			echo "Target adress responed to ping request!"
			echo "${TARGET} pinged successfully!"
			echo "-------------------------------------------" >> $HOME/responded-ping-requests-${i}.xxx.txt
		else
			nslookup $TARGET >> $HOME/non-responded-ping-requests-${i}.xxx.txt
			echo "${TARGET}" >> $HOME/non-responded-ping-requests-${i}.xxx.txt
  			echo "Target adresss did not respond to ping!"
			echo "-------------------------------------------" >> $HOME/non-responded-ping-requests-${i}.xxx.txt
		fi
done
# -----------------------------------------------------------------------
