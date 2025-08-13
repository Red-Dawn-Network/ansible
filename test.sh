#!/usr/bin/env bash

docker build -t reddawntest .

# Test playbooks
if docker run -it --privileged --hostname reddawnmilsim --rm reddawntest
then
    echo "Ansible playbooks succeeded!"
    exit 0
else
    echo "Ansible playbook execution failed!"
    exit 10
fi
