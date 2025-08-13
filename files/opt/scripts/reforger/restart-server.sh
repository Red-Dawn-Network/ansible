#!/usr/bin/env bash

set -ex
/opt/scripts/reforger/discord-notify.sh "Server restart scheduled via admin interface."
/opt/scripts/reforger/disable-cron.sh
if sudo systemctl restart armaserver.service
then
  /opt/scripts/reforger/discord-notify.sh "Server successfully restarted."
else
  /opt/scripts/reforger/discord-notify.sh "Server failed to restart."
fi
/opt/scripts/reforger/enable-cron.sh
