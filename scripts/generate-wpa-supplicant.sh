#!/bin/sh

outfile=/mnt/etc/wpa_supplicant.conf

if [ -f $outfile ]; then
    echo "wpa_supplicant.conf already exists."
else
    echo -n "ESSID and password of the wireless network: "
    read essid
    wpa_passphrase $essid > $outfile
fi
