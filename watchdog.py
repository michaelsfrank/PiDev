#!/usr/bin/env python
import subprocess
import datetime
import time
import sqlite3
#import sys

#from datetime import date
#import matplotlib.dates as dt
import apsw

dbname='/var/www/Logger.db'

table_time_delta_limit=0.010416667
# 60min x 24 hrs = 1440 min/day
# 1440 min/day ^-1 = 0.00069444 day/min
# 0.00069444 day/min x 15min = 0.010416667

# http://www.ridgesolutions.ie/index.php/2013/02/22/raspberry-pi-restart-shutdown-your-pi-from-python-code/

#conn=sqlite3.connect(dbname)
conn=apsw.Connection(dbname,flags=1)
curs=conn.cursor()

table_time_max = [str(x[0]) for x in buf]

for x in range(0, 1000):
    try:
        curs.execute("SELECT Max(Time) FROM Systems_Pi3_Temp_CPUTemp")
        buf=curs.fetchall()
        break;
    except:
        time.sleep(1)
        buf=[(100,)]
try:
    print "<tr><td>", d, "</td><td>", dt.num2date(buf[0][0]), "</td></tr>"
except TypeError:
    print "<tr><td>", d, "</td><td> none </td></tr>"

conn.close()

ts = time.time()  
st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')  
now = datetime.datetime.now().toordinal()-Period
 
 
f = open('/home/pi/watchdog.log', 'a')  
# write the timestamp and text to the file  
f.write(st)  
f.write(' : REBOOT command issued\n') 
f.close()

if datetime.datetime.now().toordinal()-table_time_max > table_time_delta_limit
    command = "/usr/bin/sudo /sbin/shutdown -r now"
    sys.stderr.write('sql statements set\n')
    #process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
    #output = process.communicate()[0]
    #print output
 
