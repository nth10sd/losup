#! /bin/bash -e
echo;
echo "This script is for OnePlus 3T.";
echo;
echo "Sample usage: <script> <datestamp of LineageOS build> <datestamp of OpenGApps build>";
echo 'Make sure to have run "pkg install aria2 perl tsu" beforehand!';
echo 'OP3T: Make sure to have downloaded https://dl.twrp.me/oneplus3/twrp-3.4.0-0-oneplus3.img beforehand!';
echo "Press any key once all aria2c commands finish!";
echo;
echo "Press any key once you have read the above...";
echo;
read;
echo "Downloading files...";
pushd $HOME;
# TWRP redirects break downloading from TWRP. Just download into $HOME beforehand
aria2c --force-sequential=true --max-connection-per-server=5 --split=10 \
    https://mirrorbits.lineageos.org/full/oneplus3/$1/lineage-17.1-$1-nightly-oneplus3-signed.zip \
    https://downloads.sourceforge.net/project/opengapps/arm64/$2/open_gapps-arm64-10.0-nano-$2.zip \
    https://downloads.sourceforge.net/project/opengapps/arm64/$2/open_gapps-arm64-10.0-nano-$2.zip.md5 \
    https://github.com/topjohnwu/Magisk/releases/download/v22.0/Magisk-v22.0.apk;
popd;
echo "Press any key once all aria2c instances have completed successfully, else press Ctrl-C to abort.";
read;

# Set variable names
LOS_FILENAME="lineage-17.1-$1-nightly-oneplus3-signed";
TWRP_FILENAME="twrp-3.4.0-0-oneplus3";
OGA_FILENAME="open_gapps-arm64-10.0-nano-$2";
MAG_FILENAME="Magisk-v22.0";

echo "Verifying checksums...";
aria2c https://mirrorbits.lineageos.org/full/oneplus3/$1/lineage-17.1-$1-nightly-oneplus3-signed.zip?sha256
shasum -c $HOME/$LOS_FILENAME.1.zip;  # Not a zip file, it is the SHA256 hash
aria2c https://dl.twrp.me/oneplus3/twrp-3.4.0-0-oneplus3.img.sha256
sudo shasum -c $HOME/$TWRP_FILENAME.img.sha256;
md5sum -c $HOME/$OGA_FILENAME.zip.md5;
echo "dcb0a1f84f629fe31a3b39bd222241a93f74fb5caf48c521e5a5aca4459e1bf1 *$MAG_FILENAME.apk" > $HOME/$MAG_FILENAME.apk.sha256;
shasum -c $HOME/$MAG_FILENAME.apk.sha256;

echo "Removing checksum files...";
rm $HOME/$LOS_FILENAME.1.zip $HOME/$TWRP_FILENAME.img.sha256 $HOME/$OGA_FILENAME.zip.md5 $HOME/$MAG_FILENAME.apk.sha256;

echo "Changing permissions..."
chmod 660 $HOME/$LOS_FILENAME.zip;
sudo chown root $HOME/$LOS_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$LOS_FILENAME.zip;
chmod 660 $HOME/$TWRP_FILENAME.img;
sudo chown root $HOME/$TWRP_FILENAME.img;
sudo chgrp sdcard_rw $HOME/$TWRP_FILENAME.img;
chmod 660 $HOME/$OGA_FILENAME.zip;
sudo chown root $HOME/$OGA_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$OGA_FILENAME.zip;
chmod 660 $HOME/$MAG_FILENAME.apk;
sudo chown root $HOME/$MAG_FILENAME.apk;
sudo chgrp sdcard_rw $HOME/$MAG_FILENAME.apk;

echo "Moving files...";
sudo mv $HOME/$LOS_FILENAME.zip /sdcard/;
sudo mv $HOME/$TWRP_FILENAME.img /sdcard/;
sudo mv $HOME/$OGA_FILENAME.zip /sdcard/;
sudo mv $HOME/$MAG_FILENAME.apk /sdcard/$MAG_FILENAME.zip;

echo "Script completed!";
echo "Boot to recovery, flash the new Lineage OS file, then TWRP...";
echo "Reboot into recovery again, flash Open GApps and Magisk yet again...";
echo "Reboot into system. No need to wipe any caches.";
echo "Remember to make backups, good luck!";
