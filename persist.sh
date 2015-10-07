#!/bin/bash
# Pi2
# 25-Jul-2015
# copy to Pi4 11-Aug-2015 from EHD3
# need to recover original for proper logging
# 2015 09 03 copy from Pi4 to Pi3


LOGFILE="persist.log"
NOW="$(date +%d/%m/%Y' - '%H:%M)" # date & time of log

echo "[$NOW] Logger_persist"
echo "[$NOW] Logger_persist.sh script launched" >> $LOGFILE

a=`ps -ef | grep Logger | grep -v grep`
#b=`ps -ef | grep autossh | grep -v grep`
c=`netstat -tulpn | grep 22883 | grep -v grep`

#echo a >> $LOGFILE
#echo b >> $LOGFILE
#echo $a >> $LOGFILE
#echo $b >> $LOGFILE
#echo "$a" >> $LOGFILE
#echo "$b" >> $LOGFILE
#echo ! "$a" >> $LOGFILE
#echo ! "$b" >> $LOGFILE

if [ ! "$a" ]; then
	echo "[$NOW] Logger is not running" >> $LOGFILE
	sudo ./Logger/Logger &
else
	echo "[$NOW] Logger is running" >> $LOGFILE
fi


#if [ ! "$b" ]; then
#	echo "[$NOW] autossh is not running" >> $LOGFILE
#
    #ssh -v -N -R 9091:localhost:22 pi@frafle.ddns.net
#    date
#    echo Relaunch autossh
#    autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -R \*:9942:localhost:2002 frafle.ddns.net -p 2004 2>> autossh_9942.log &
#    autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -R \*:9932:localhost:2002 frafle.ddns.net -p 2003 2>> autossh_9932.log &

#else
#	echo "[$NOW] autossh is running" >> $LOGFILE
#fi


if [ ! "$c" ]; then
        echo "[$NOW] SSH MQTT port 22883 is not open!!!!!!!!!!!!!!!!!!!!!!!!!!" >> $LOGFILE
        ssh -f -L \*:22883:127.0.0.1:1883 pi@192.168.1.214 -p 2004 -N -i /home/pi/.ssh/id_rsa 2>> $LOGFILE &
else
        echo "[$NOW] SSH MQTT port 22883 is open" >> $LOGFILE
fi

