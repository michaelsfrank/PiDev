#!/bin/bash
# Pi2
# 25-Jul-2015
# copy to Pi4 11-Aug-2015 from EHD3
# need to recover original for proper logging
# 2015 09 03 copy from Pi4 to Pi3


LOGFILE="/home/pi/persist.log"
NOW="$(date +%d/%m/%Y' - '%H:%M)" # date & time of log

echo "[$NOW] persist.sh launched"
echo "[$NOW] persist.sh launched" >> $LOGFILE


#b=`ps -ef | grep autossh | grep -v grep`


#echo a >> $LOGFILE
#echo b >> $LOGFILE
#echo $a >> $LOGFILE
#echo $b >> $LOGFILE
#echo "$a" >> $LOGFILE
#echo "$b" >> $LOGFILE
#echo ! "$a" >> $LOGFILE
#echo ! "$b" >> $LOGFILE

logger=`ps -ef | grep Logger | grep -v grep`
if [ ! "$logger" ]; then
	echo "[$NOW] Logger is NOT running" >> $LOGFILE
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

case $(hostname -s) in
  Pi1)
    echo Pi1
    autossh9931=`ps -ef | grep autossh | grep -v grep | grep 9931`
    autossh9951=`ps -ef | grep autossh | grep -v grep | grep 9951`
    if [ ! "$autossh9931" ]; then
            echo "[$NOW] autossh is not running on port 9931... starting autossh on port 9931" >> $LOGFILE
            autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -v -R \*:9931:localhost:2001 frafle.ddns.net -p 2003 2>> autossh_9931.log &
    else
            echo "[$NOW] autossh is running on port 9931" >> $LOGFILE
    fi

    if [ ! "$autossh9951" ]; then
            echo "[$NOW] autossh is not running on port 9951... starting autossh on port 9951" >> $LOGFILE
            autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -v -R \*:9951:localhost:2001 frafle.ddns.net -p 2005 2>> autossh_9951.log &
    else
            echo "[$NOW] autossh is running on port 9951" >> $LOGFILE
    fi

    ;;
  Pi2)
    echo Pi2
    autossh9932=`ps -ef | grep autossh | grep -v grep | grep 9932`
    autossh9952=`ps -ef | grep autossh | grep -v grep | grep 9952`
    if [ ! "$autossh9932" ]; then
            echo "[$NOW] autossh is not running on port 9932... starting autossh on port 9932" >> $LOGFILE
            autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -v -R \*:9932:localhost:2002 frafle.ddns.net -p 2003 2>> autossh_9932.log &
    else
            echo "[$NOW] autossh is running on port 9932" >> $LOGFILE
    fi

    if [ ! "$autossh9952" ]; then
            echo "[$NOW] autossh is not running on port 9952... starting autossh on port 9952" >> $LOGFILE
            autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -v -R \*:9952:localhost:2002 frafle.ddns.net -p 2005 2>> autossh_9952.log &
    else
            echo "[$NOW] autossh is running on port 9952" >> $LOGFILE
    fi

    ;;
  Pi3)
    echo Pi3

    ;;
  Pi5)
    echo Pi5
    mqtt=`netstat -tulpn | grep 22883 | grep -v grep`
    if [ ! "$mqtt" ]; then
        echo "[$NOW] SSH MQTT port 22883 is not open!!!!!!!!!!!!!!!!!!!!!!!!!!" >> $LOGFILE
        ssh -f -L \*:22883:127.0.0.1:1883 pi@192.168.1.215 -p 2005 -N -i /home/pi/.ssh/id_rsa 2>> $LOGFILE &
    else
        echo "[$NOW] SSH MQTT port 22883 is open" >> $LOGFILE
    fi

    ;;
esac

