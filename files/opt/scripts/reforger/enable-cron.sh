#!/usr/bin/env bash

printf "%s\n* * * * * /opt/scripts/reforger/armacheck.sh\n" "$(sudo crontab -l | grep -v '/opt/scripts/reforger/armacheck.sh')" | sudo crontab -
