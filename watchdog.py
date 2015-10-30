#!/usr/bin/env python

# http://docs.python-guide.org/en/latest/scenarios/scrape/

# Requests: HTTP for Humans    http://docs.python-requests.org/en/v1.0.1/
# sudo pip install requests

# http://lxml.de/tutorial.html

# https://docs.python.org/2/library/xml.etree.elementtree.html

# sudo apt-get install python-lxml
# http://lxml.de/parsing.html

from lxml import html
import requests
import datetime
import time
import subprocess
import socket

print "socket.gethostname(): ", socket.gethostname()

def dtt2timestamp(dtt):
    ts = (dtt.hour * 60 + dtt.minute) * 60 + dtt.second
    #if you want microseconds as well
    #ts += dtt.microsecond * 10**(-6)
    total=24*60*60
    result=float(ts)/float(total)
    #print ts, " / ", total, " = ", result
    return result


page = requests.get('http://frafle.ddns.net/cgi-bin/table-age-cpu2.py?Table=Systems_{0}_Temp_CPUTemp'.format(socket.gethostname()))

# http://lxml.de/lxmlhtml.html
root = html.fromstring(page.text)

#print "root: ", root
#print "root.tag: ", root.tag
#print "root.attrib: ", root.attrib

#for child in root:
#    print "  child: ", child
#    print "  child.tag: ", child.tag
#    print "  child.attrib: ", child.attrib
#    print "  child.text: ", child.text
#    #print "  child.value: ", child.value
#    for subchild in child:
#        print "    subchild: ", subchild

#print datetime.datetime.now().time()
#print dtt2timestamp(datetime.datetime.now().time())
#print float(datetime.datetime.now().toordinal()+dtt2timestamp(datetime.datetime.now().time()))

rightnow = float( datetime.datetime.now().toordinal() + dtt2timestamp(datetime.datetime.now().time()) )
print "rightnow = ", rightnow

ts = time.time()
st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
f = open('/home/pi/watchdog.log', 'a')
f.write(st)
f.write(' - {0} - cputemp expired - REBOOT command issued\n'.format(socket.gethostname()))

for element in root.iter("cputemp"):
    if (rightnow-float(element.text))>0.01:
        f.write(' : cputemp expired - REBOOT command issued\n') 
        #print("element.tag=%s - element.text=%s" % (element.tag, element.text))
        #print float(element.text)
        print "rightnow - max = ", rightnow, " - ", float(element.text), " = ", rightnow-float(element.text)

        print "cputemp expired - REBOOT command issued\n"
        command = "/usr/bin/sudo /sbin/shutdown -r now"
#        sys.stderr.write('sql statements set\n')
        process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
        output = process.communicate()[0]
        print output

    else:
        print "cputemp has not expired - no need to reboot\n"
        f.write(" : cputemp has not expired - no need to reboot\n") 
    f.close()

