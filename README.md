Ansible playbooks for Red Dawn Network servers. Expected to run against Ubuntu LTS.

## Setup

Install Ansible and dependencies:

```
sudo apt update
sudo apt install python3 software-properties-common git curl -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```

Install Ansible collections:

```
curl -L https://raw.githubusercontent.com/Red-Dawn-Network/ansible/refs/heads/main/requirements.yml -o /tmp/requirements.yml
sudo ansible-galaxy install -r /tmp/requirements.yml
```

## Usage

Run against the GitHub repository like so:

```
sudo ansible-pull -U https://github.com/Red-Dawn-Network/ansible main.yml
```

## Host-specific documentation

### reddawnmilsim

Arma Reforger Server was installed as user `scott` following these instructions: [Deploy Arma Reforger Game Servers: Install](https://linuxgsm.com/servers/armarserver)

In order to the reforger scripts to work as expected, create `/opt/scripts/reforger/.env` with the following contents:

```
webhook="https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
server_port="17777"
linuxgsm_home="/home/scott"
```

### reddawnpvp

Arma Reforger Server was installed as user `scott` following these instructions: [Deploy Arma Reforger Game Servers: Install](https://linuxgsm.com/servers/armarserver)

In order to the reforger scripts to work as expected, create `/opt/scripts/reforger/.env` with the following contents:

```
webhook="https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
server_port="17777"
linuxgsm_home="/home/scott"
```

## Development

Create a new branch, make changes and push:

```
# create branch
git checkout -b some-branch-name

# make changes

# test changes
./test.sh

# commit and push
git commit -m 'some cool changes I made'
git push origin some-branch-name
```

After making changes to playbooks -- before pushing to GitHub -- run `test.sh` in the root of the repository and ensure you didn't break anything.
