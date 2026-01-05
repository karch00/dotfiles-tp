#!/usr/bin/bash

### INTERFACE ###
INTERFACE=$(ip l | grep " UP " | pcregrep -o '[0-9]+: [a-z0-9]+:' | pcregrep -o '[a-z0-9]{2,}' | head -1)
if [[ $INTERFACE == "" ]]; then
  INTERFACE="No interface"
fi

TYPE=$(nmcli -g GENERAL.TYPE device show $INTERFACE)
if [[ $TYPE == "wifi" ]]; then
  INTERFACE_ICON="󰖩"
elif [[ $TYPE == "ethernet" ]]; then
  INTERFACE_ICON=""
elif [[ $TYPE == "tunnel" ]]; then
  INTERFACE_ICON="󰖂"
else
  INTERFACE_ICON=""
fi

if [[ $TYPE == "wifi" ]]; then
  ESSID=$(nmcli -g GENERAL.CONNECTION device show $INTERFACE)
else
  ESSID="No AP"
fi


### ADRESSES ###
PRIV=$(ip a | pcregrep -A 5 "state UP \X+" | pcregrep -o '(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:(?!255|1)(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[2-9]))' | head -1)
if [[ $PRIV == "" ]]; then
  PRIV="No IP"
fi

MAC=$(ip a | pcregrep -A 5 "state UP \X+" | pcregrep -o '(?!(ff:){5}ff|(00:){5}00)(?:[0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' | head -1)
if [[ $MAC == "" ]]; then
  MAC="No MAC"
fi

PUBLIC=$(curl "https://api.ipify.org")
# TODO Generalize to errors
if [[ $PUBLIC == "curl: (6) Could not resolve host: api.ipify.org" ]]; then
  PUBLIC="No IP"
fi



### OUTPUT ###
echo -e "$INTERFACE_ICON $INTERFACE\n󰀃 $ESSID\n󰇄 $MAC\n󰌗 $PRIV\n󰖈 $PUBLIC"

