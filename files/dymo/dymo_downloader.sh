#!/bin/bash

# https://www.dymo.com/compatibility-chart.html

WIN_FILE="DLS8Setup.8.7.4.exe"
WIN_URL="https://s3.amazonaws.com/download.dymo.com/dymo/Software/Win/DLS8Setup8.7.4.exe"

MAC_FILE="DCDMac1.4.3.103.pkg"
MAC_URL="https://s3.amazonaws.com/download.dymo.com/dymo/Software/Mac/DCDMac1.4.3.103.pkg"

cd /usr/share/dymo/

if [[ -f $WIN_FILE && -f $MAC_FILE ]]; then
	exit 0
fi

rm -f $WIN_FILE $MAC_FILE

wget $WIN_URL -O $WIN_FILE
wget $MAC_URL -O $MAC_FILE

chmod o+r *
