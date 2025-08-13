#!/usr/bin/env bash

source /opt/scripts/reforger/.env

# https://www.reddit.com/r/armadev/comments/uw6g37/comment/ia6rxey
PATTERN1=.".*IReplication.*Finishing"
PATTERN2=.".*Game destroyed"
LOGFILE="${linuxgsm_home}/log/console/armarserver-console.log"

echo "Monitoring for game completion."
tail -f "${LOGFILE}" | while read LINE
do
  if [[ $LINE =~ $PATTERN1 ]] || [[ $LINE =~  $PATTERN2 ]]
  then
    /opt/scripts/reforger/discord-notify.sh "Detected game completion, restarting server."
    sudo systemctl restart armaserver.service
  fi
done
