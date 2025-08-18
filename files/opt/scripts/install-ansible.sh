#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

sudo apt update
sudo apt install -y git curl software-properties-common

if ! dpkg -l ansible &>/dev/null
then
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
fi

# Install ansible-lint in case dev happens on red-dawn servers
dpkg -l ansible-lint &>/dev/null || sudo apt install -y ansible ansible-lint
