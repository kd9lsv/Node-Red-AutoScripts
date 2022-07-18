#!/bin/bash


# Are you wanting to update Node-Red?
read -p "Are you wanting to update Node-Red? (Y/n) " flag_update
# Are you a dev?
#read -p "Are you planning to help develop any of the dashboards? (y/N)" flag_dev
# Ask which Dashboard are you looking for?
while true; do
  printf "Pick which Dashboard are you looking for? \n Choose only 1. \n \n 1. Contesting Node-Red Dashboard \n 2. POTA Node-Red Dashboard\n"
  read -p "What is your choice? " flag_choice
  if  [[ ! $flag_choice -eq 1 ]] && [[ ! $flag_choice -eq 2 ]] ; then
    echo "You chose an incorrect number. Please choose a proper project."
      continue
  else
    break
  fi
done

# Update RPI
echo "Updating and Upgrading your Pi to newest standards"
sudo apt update -qq > /dev/null && sudo apt full-upgrade -qq -y > /dev/null && sudo apt clean > /dev/null
wait

#Install Node-Red
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) <<!
y
y
!
wait
# Start NodeRed
sudo systemctl start nodered.service
sudo systemctl enable nodered.service
# Install git & Sqlite3
sudo apt-get install git sqlite3 -qq > /dev/null
wait
# Configure SQLITE
cd /home/pi
if [[ $flag_choice -eq 1 ]] ; then
sqlite3 qsos<<!
CREATE TABLE IF NOT EXISTS qsos(
  "app" TEXT,
  "contestname" TEXT,
  "contestnr" TEXT,
  "timestamp" TEXT,
  "mycall" TEXT,
  "band" TEXT,
  "rxfreq" TEXT,
  "txfreq" TEXT,
  "operator" TEXT,
  "mode" TEXT,
  "call" TEXT,
  "countryprefix" TEXT,
  "wpxprefix" TEXT,
  "stationprefix" TEXT,
  "continent" TEXT,
  "snt" TEXT,
  "sntnr" TEXT,
  "rcv" TEXT,
  "rcvnr" TEXT,
  "gridsquare" TEXT,
  "exchange1" TEXT,
  "section" TEXT,
  "comment" TEXT,
  "qth" TEXT,
  "name" TEXT,
  "power" TEXT,
  "misctext" TEXT,
  "zone" TEXT,
  "prec" TEXT,
  "ck" TEXT,
  "ismultiplier1" TEXT,
  "ismultiplier2" TEXT,
  "ismultiplier3" TEXT,
  "points" TEXT,
  "radionr" TEXT,
  "run1run2" TEXT,
  "RoverLocation" TEXT,
  "RadioInterfaced" TEXT,
  "NetworkedCompNr" TEXT,
  "IsOriginal" TEXT,
  "NetBiosName" TEXT,
  "IsRunQSO" TEXT,
  "StationName" TEXT,
  "ID" TEXT,
  "IsClaimedQso" TEXT,
  "lat" TEXT,
  "lon" TEXT,
  "isbusted" TEXT,
  "distance" TEXT
);
CREATE TABLE IF NOT EXISTS radio(
  "timestamp" TEXT,
  "app" TEXT,
  "StationName" TEXT,
  "RadioNr" TEXT,
  "Freq" TEXT,
  "TXFreq" TEXT,
  "Mode" TEXT,
  "OpCall" TEXT,
  "IsRunning" TEXT,
  "FocusEntry" TEXT,
  "EntryWindowHwnd" TEXT,
  "antenna" TEXT,
  "Rotors" TEXT,
  "FocusRadioNr" TEXT,
  "IsStereo" TEXT,
  "IsSplit" TEXT,
  "ActiveRadioNr" TEXT,
  "IsTransmitting" TEXT,
  "FunctionKeyCaption" TEXT,
  "RadioName" TEXT,
  "AuxAntSelected" TEXT,
  "AuxAntSelectedName" TEXT
);
CREATE TABLE IF NOT EXISTS spots(
  "timestamp" TEXT,
  "call" TEXT type UNIQUE,
  "lat" TEXT,
  "lon" TEXT,
  "grid" TEXT
);
CREATE INDEX call_idx on spots(call);
.exit
!

elif [[ $flag_choice -eq 2 ]] ; then

sqlite3 pota<< !

CREATE TABLE validparksdesignator(
  "designator" TEXT type UNIQUE
);
CREATE TABLE designatoralert(
 "designator" TEXT type UNIQUE
);
CREATE TABLE callsignalert(
 "callsign" TEXT type UNIQUE
);
CREATE TABLE parkalert(
 "park" TEXT type UNIQUE
);
CREATE TABLE huntedparks(
  "DXCCEntity" TEXT,
  "Location" TEXT,
  "HASC" TEXT,
  "Reference" TEXT type UNIQUE,
  "ParkName" TEXT,
  "FirstQSODate" TEXT,
  "QSOs" INTEGER
);
CREATE TABLE locdescalert(
 "locdesc" TEXT type UNIQUE
);
.exit
!

fi


#configure NodeRed
node-red-stop
wait
cd /home/pi/.node-red
npm install @node-red-contrib-themes/theme-collection
curl -o settings.js https://gist.githubusercontent.com/kd9lsv/b114c87eb3f30b4d3cc53009d486978f/raw/c84a38d999ef8c4562237b531cfc4bcd5f26efab/settings.js
mkdir projects
cd projects
echo "Cloning the Node-Red Dashboard"
if [[ $flag_choice -eq 1 ]] ; then
git clone https://github.com/kylekrieg/Node-Red-Contesting-Dashboard.git
cd Node-Red-Contesting-Dashboard
elif [[ $flag_choice -eq 2 ]] ; then
git clone https://github.com/kylekrieg/Node-Red-POTA-Dashboard.git
cd Node-Red-POTA-Dashboard
fi
npm --prefix ~/.node-red/ install ~/.node-red/projects/Node-Red-Contesting-Dashboard/


sudo systemctl restart nodered.service
echo "Node Red has Completed. Send to AA0Z to test".
