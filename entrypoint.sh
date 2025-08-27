#!/usr/bin/env bash

if [[ -f /local/main.yml ]]
then
    ansible-playbook --connection=local /local/main.yml
else
    ansible-playbook --connection=local /ansible/main.yml
fi
