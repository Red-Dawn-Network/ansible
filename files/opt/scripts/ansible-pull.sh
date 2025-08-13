#!/usr/bin/env bash

sudo /opt/scripts/install-ansible.sh
sudo ansible-pull -U https://github.com/Red-Dawn-Network/ansible main.yml
