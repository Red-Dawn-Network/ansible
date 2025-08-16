#!/usr/bin/env bash

docker build -t reddawntest .

# Test playbooks
for host in "reddawnmillsim" "reddawnpvp"
do
    echo "" > .${host}-ansible.log
    if docker run -it -v "$(pwd):/ansible" -v "$(pwd)/.${host}-ansible.log:/ansible.log" --privileged --hostname "${host}" --rm reddawntest
    then
        echo "Ansible playbooks succeeded for ${host}!"
        exit 0
    else
        echo "Ansible playbook execution failed for ${host}!"
        echo "Check logs at $(pwd)/${host}-ansible.log"
        exit 10
    fi
done
