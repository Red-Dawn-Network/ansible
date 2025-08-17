#!/usr/bin/env bash

source /opt/scripts/reforger/.env
server_ip="$(ip -br -4 -j addr show dev eth0 | jq -r '.[0].addr_info[0].local')"
hostname="$(hostname)"

# Check last state
state=""
if [[ -e /tmp/state.txt ]] # if file does not exist, assume a restart happened, don't send a notification
then
  if grep -q 'online' /tmp/state.txt
  then
    state="online"
  else
    state="offline"
  fi
fi

if curl --silent -L "https://ismygameserver.online/armareforger/${server_ip}:${server_port}" | grep -q 'YES 🙂'
then
  echo "Server ${hostname} is online!" | tee /tmp/state.txt
  if [[ "${state}" == "offline" ]]
  then
    /opt/scripts/reforger/discord-notify.sh "Server is back up! https://ismygameserver.online/armareforger/${server_ip}:${server_port}"
  fi
elif curl --silent -L "https://ismygameserver.online/armareforger/${server_ip}:${server_port}" | grep -q 'NO ☹️'
then
  echo "Server ${hostname} is offline!" | tee /tmp/state.txt
  if [[ "${state}" == "online" ]]
  then
    /opt/scripts/reforger/discord-notify.sh "Server ${hostname} is offline! https://ismygameserver.online/armareforger/${server_ip}:${server_port}"
  fi
else
  echo "Unexpected error checking server status on ismygameserver.online -- check again later."
fi
