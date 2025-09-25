#!/usr/bin/env bash

targets="$@"
[[ -z "${targets[*]}" ]] && targets=("red-dawn-mgmt" "reddawnmilsim" "reddawnrust")

# Mainly for GitHub Actions
if [[ -z $SKIP_ANSIBLE_LINT ]]
then
    if ! command -v ansible-lint &>/dev/null
    then
        sudo apt install -y ansible-lint
        if ! command -v ansible-lint &>/dev/null
        then
            echo "Unable to install ansible-lint. Please install ansible-lint (sudo apt install -y ansible-lint). Exiting."
            exit 1
        fi
    fi
    ansible-lint main.yml tasks/* || exit 20
fi

echo "Building test container..."
build_log="$(pwd)/.build.log"
rm -f "${build_log}"
if docker build -t reddawntest . &> "${build_log}"
then
    echo "Successfully built test container"
else
    echo "Failed to build test container! Exiting!"
    echo "Check logs at ${build_log}."
    exit 10
fi

status="success"
# Test playbooks
for host in "${targets[@]}"
do
    log_file="$(pwd)/.${host}-ansible.log"
    echo "" > "${log_file}"
    echo "Testing ${host} ansible playbooks in Docker..."
    echo "To view output run the following command in another terminal: docker logs -f ${host}"
    run_command="docker run -it -v="$(pwd):/local" -v="${log_file}:/ansible.log" --privileged --hostname="${host}" --name="${host}" --rm reddawntest"
    if ${run_command} &>/dev/null
    then
        echo "Ansible playbooks succeeded for ${host}!"
    else
        status="failed"
        echo "Ansible playbook execution failed for ${host}!"
        if [[ ${PRINT_LOGS} == "true" ]]
        then
            cat "${log_file}"
        else
            echo "Check logs at ${log_file}."
        fi
        echo "Command that failed: ${run_command}"
    fi
done

[[ "${status}" == "failed" ]] && exit 3
exit 0
