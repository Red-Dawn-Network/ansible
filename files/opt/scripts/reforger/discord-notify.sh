#!/usr/bin/env bash

source /opt/scripts/reforger/.env

current_date=$(TZ="MST" date)
/opt/discord-sh/discord.sh --webhook-url="${webhook}" --text "${current_date} $1"
