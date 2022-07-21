#! /bin/bash -e
echo;
echo "This script is for OnePlus 6T.";
echo;
echo "Sample usage: <script> <datestamp of LineageOS build>";
echo 'Make sure to have run "pkg install -y aria2 perl tsu" beforehand!';
echo "Press any key once all aria2c commands finish!";
echo;
echo "Press any key once you have read the above...";
echo;
read;
echo "Downloading files...";
pushd $HOME;
aria2c --force-sequential=true --max-connection-per-server=5 --split=10 \
    https://mirrorbits.lineageos.org/full/fajita/$1/lineage-19.1-$1-nightly-fajita-signed.zip \
    https://dl.twrp.me/fajita/twrp-installer-3.6.2_9-0-fajita.zip;
popd;
echo "Press any key once all aria2c instances have completed successfully, else press Ctrl-C to abort.";
read;

# Set variable names
LOS_FILENAME="lineage-19.1-$1-nightly-fajita-signed";
TWRP_FILENAME="twrp-installer-3.6.2_9-0-fajita";

echo "Verifying checksums...";
aria2c https://mirrorbits.lineageos.org/full/fajita/$1/lineage-19.1-$1-nightly-fajita-signed.zip?sha256
shasum -c $HOME/$LOS_FILENAME.1.zip;  # Not a zip file, it is the SHA256 hash
echo "b88383ab79f4e7d31e58ed44f5bdcfe3f7ab1639f87188b514af315c794de8af *$TWRP_FILENAME.zip" > $HOME/$TWRP_FILENAME.zip.sha256;
shasum -c $HOME/$TWRP_FILENAME.zip.sha256;

echo "Removing checksum files...";
rm $HOME/$LOS_FILENAME.1.zip $HOME/$TWRP_FILENAME.zip.sha256;

echo "Changing permissions..."
chmod 660 $HOME/$LOS_FILENAME.zip;
sudo chown root $HOME/$LOS_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$LOS_FILENAME.zip;
chmod 660 $HOME/$TWRP_FILENAME.zip;
sudo chown root $HOME/$TWRP_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$TWRP_FILENAME.zip;

echo "Moving files...";
sudo mv $HOME/$LOS_FILENAME.zip /sdcard/;
sudo mv $HOME/$TWRP_FILENAME.zip /sdcard/;

echo "Script completed!";
echo "DO NOT use Open GApps and Magisk, download MindTheGapps and Magisk separately...";
echo "Boot to recovery, flash the new Lineage OS file, then TWRP...";
echo "Reboot into recovery again, flash MindTheGapps...";
echo "Reboot into system. No need to wipe any caches.";
echo "Install Magisk and FoxMagiskModuleManager, activate zygisk and denylist, reboot";
echo "Install safetynet-fix from kdrag0n, Shamiko from LSPosed, both on GitHub";
echo "Install Energized Protection, use blu with regional and social extensions";
echo "Remember to make backups, good luck!";
