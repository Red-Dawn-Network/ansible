#!/usr/bin/env bash

sudo rm -f /var/log/ansible-log.txt &>/dev/null || true
sudo /opt/scripts/install-ansible.sh &>/var/log/ansible-log.txt
sudo ansible-pull -U https://github.com/Red-Dawn-Network/ansible main.yml &>/var/log/ansible-log.txt
