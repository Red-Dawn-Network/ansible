#!/usr/bin/env bash

source /opt/scripts/reforger/.env

current_date=$(TZ="MST" date)
if ps aux | grep -v grep | grep -iq ArmaReforgerServer
then
	echo "${current_date} Arma Reforger server is running! Exiting." >> /tmp/armacheck.log
else
	echo "${current_date} Arma Reforger server is down! Restarting automatically." >> /tmp/armacheck.log
	/opt/discord-sh/discord.sh --webhook-url="${webhook}" --text "${current_date} Arma Reforger server is down, restarting automatically!"
	sudo systemctl restart armaserver.service
fi
