#! /bin/bash -e
echo;
echo "Sample usage: <script> <datestamp of LineageOS build> <datestamp of OpenGApps build>";
echo 'Make sure to have run "pkg install aria2 perl tsu" beforehand!';
echo "Press any key once all aria2c commands finish!";
echo;
echo "Press any key once you have read the above...";
echo;
read;
echo "Downloading files...";
pushd $HOME;
aria2c --force-sequential=true --max-connection-per-server=5 --split=10 \
    https://mirrorbits.lineageos.org/full/fajita/$1/lineage-18.1-$1-nightly-fajita-signed.zip \
    https://downloads.sourceforge.net/project/opengapps/arm64/$2/open_gapps-arm64-11.0-nano-$2.zip \
    https://downloads.sourceforge.net/project/opengapps/arm64/$2/open_gapps-arm64-11.0-nano-$2.zip.md5 \
    https://downloads.sourceforge.net/project/mauronofrio-twrp/Fajita/twrp-3.3.1-32-fajita-installer-mauronofrio.zip \
    https://github.com/topjohnwu/Magisk/releases/download/v23.0/Magisk-v23.0.apk
popd;
echo "Press any key once all aria2c instances have completed successfully, else press Ctrl-C to abort.";
read;

# Set variable names
LOS_FILENAME="lineage-18.1-$1-nightly-fajita-signed";
TWRP_FILENAME="twrp-3.3.1-32-fajita-installer-mauronofrio";
OGA_FILENAME="open_gapps-arm64-11.0-nano-$2";
MAG_FILENAME="Magisk-v23.0";

echo "Verifying checksums...";
aria2c https://mirrorbits.lineageos.org/full/fajita/$1/lineage-18.1-$1-nightly-fajita-signed.zip?sha256
shasum -c $HOME/$LOS_FILENAME.1.zip;  # Not a zip file, it is the SHA256 hash
echo "e6c36b0a9ddc092e03038e5a4178ed8ce2206089e1d1067b0b0af10ba51ccfa2 *$TWRP_FILENAME.zip" > $HOME/$TWRP_FILENAME.zip.sha256;
shasum -c $HOME/$TWRP_FILENAME.zip.sha256;
md5sum -c $HOME/$OGA_FILENAME.zip.md5;
echo "079bc3a7f67413cb12509d1b811958dd7e7c7fb593d3f0507954fea72077b524 *$MAG_FILENAME.apk" > $HOME/$MAG_FILENAME.apk.sha256;
shasum -c $HOME/$MAG_FILENAME.apk.sha256;

echo "Removing checksum files...";
rm $HOME/$LOS_FILENAME.1.zip $HOME/$TWRP_FILENAME.zip.sha256 $HOME/$OGA_FILENAME.zip.md5 $HOME/$MAG_FILENAME.apk.sha256;

echo "Changing permissions..."
chmod 660 $HOME/$LOS_FILENAME.zip;
sudo chown root $HOME/$LOS_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$LOS_FILENAME.zip;
chmod 660 $HOME/$TWRP_FILENAME.zip;
sudo chown root $HOME/$TWRP_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$TWRP_FILENAME.zip;
chmod 660 $HOME/$OGA_FILENAME.zip;
sudo chown root $HOME/$OGA_FILENAME.zip;
sudo chgrp sdcard_rw $HOME/$OGA_FILENAME.zip;
chmod 660 $HOME/$MAG_FILENAME.apk;
sudo chown root $HOME/$MAG_FILENAME.apk;
sudo chgrp sdcard_rw $HOME/$MAG_FILENAME.apk;

echo "Moving files...";
sudo mv $HOME/$LOS_FILENAME.zip /sdcard/;
sudo mv $HOME/$TWRP_FILENAME.zip /sdcard/;
sudo mv $HOME/$OGA_FILENAME.zip /sdcard/;
sudo mv $HOME/$MAG_FILENAME.apk /sdcard/$MAG_FILENAME.zip;

echo "Script completed!";
echo "DO NOT use Open GApps and Magisk, download MindTheGapps and Magisk separately...";
echo "Boot to recovery, flash the new Lineage OS file, then TWRP...";
echo "Reboot into recovery again, flash MindTheGapps...";
echo "Reboot into system. No need to wipe any caches.";
echo "Install Magisk and FoxMagiskModuleManager, activate zygisk and denylist, reboot";
echo "Install safetynet-fix from kdrag0n, Shamiko from LSPosed, both on GitHub";
echo "Install Energized Protection, use blu with regional and social extensions";
echo "Remember to make backups, good luck!";
