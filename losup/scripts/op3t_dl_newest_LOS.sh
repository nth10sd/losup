#! /bin/bash -e
echo;
echo "This script is for OnePlus 3T.";
echo;
echo "Sample usage: <script> <datestamp of LineageOS build>";
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
    https://mirrorbits.lineageos.org/full/oneplus3/$1/lineage-18.1-$1-nightly-oneplus3-signed.zip;
popd;
echo "Press any key once all aria2c instances have completed successfully, else press Ctrl-C to abort.";
read;

# Set variable names
LOS_FILENAME="lineage-18.1-$1-nightly-oneplus3-signed";
TWRP_FILENAME="twrp-3.4.0-0-oneplus3";

echo "Verifying checksums...";
aria2c https://mirrorbits.lineageos.org/full/oneplus3/$1/lineage-18.1-$1-nightly-oneplus3-signed.zip?sha256
shasum -c $HOME/$LOS_FILENAME.1.zip;  # Not a zip file, it is the SHA256 hash
aria2c https://dl.twrp.me/oneplus3/twrp-3.4.0-0-oneplus3.img.sha256
sudo shasum -c $HOME/$TWRP_FILENAME.img.sha256;

echo "Removing checksum files...";
rm $HOME/$LOS_FILENAME.1.zip $HOME/$TWRP_FILENAME.img.sha256;

echo "Changing permissions..."
chmod 660 $HOME/$LOS_FILENAME.zip;
sudo chown root $HOME/$LOS_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$LOS_FILENAME.zip;
chmod 660 $HOME/$TWRP_FILENAME.img;
sudo chown root $HOME/$TWRP_FILENAME.img;
sudo chgrp sdcard_rw $HOME/$TWRP_FILENAME.img;

echo "Moving files...";
sudo mv $HOME/$LOS_FILENAME.zip /sdcard/;
sudo mv $HOME/$TWRP_FILENAME.img /sdcard/;

echo "Script completed!";
echo "DO NOT use Open GApps and Magisk, download MindTheGapps and Magisk separately...";
echo "Boot to recovery, flash the new Lineage OS file, then TWRP...";
echo "Reboot into recovery again, flash MindTheGapps...";
echo "Reboot into system. No need to wipe any caches.";
echo "Install Magisk and FoxMagiskModuleManager, activate zygisk and denylist, reboot";
echo "Install safetynet-fix from kdrag0n, Shamiko from LSPosed, both on GitHub";
echo "Install Energized Protection, use blu with regional and social extensions";
echo "Remember to make backups, good luck!";
