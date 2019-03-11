# Extract the archive to /mnt/etc/nixos and run this script

TARGET_DIR=$(dirname `dirname $PWD`)

if [ ! -f hardware-configuration.nix ]; then
    nixos-generate-config --show-hardware-config --root ${TARGET_DIR} \
                          > hardware-configuration.nix
fi

getent group nixbld >/dev/null || sudo groupadd -g 30000 nixbld
getent passwd nixbld >/dev/null || sudo useradd -u 30000 -g nixbld -G nixbld nixbld

nixos-install --root ${TARGET_DIR}

! getent passwd nixbld >/dev/null || sudo userdel nixbld
! getent group nixbld >/dev/null || sudo groupdel nixbld

outfile=${TARGET_DIR}/etc/wpa_supplicant.conf

if [ -f $outfile ]; then
    echo "wpa_supplicant.conf already exists."
else
    echo -n "ESSID and password of the wireless network: "
    read essid
    wpa_passphrase $essid > $outfile
fi
