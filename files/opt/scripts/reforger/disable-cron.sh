#!/usr/bin/env bash

sudo crontab -l | grep -v '/opt/scripts/reforger/armacheck.sh' | sudo crontab -
