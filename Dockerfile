FROM docker.io/heywoodlh/systemd:ubuntu-255.4-1

ENV DEBIAN_FRONTEND=noninteractive

# Copy bare-minimum installation stuff so it can be cached and not redone anytime a change to ansible playbooks are made
COPY files/opt/scripts/install-ansible.sh /install-ansible.sh
COPY requirements.yml /requirements.yml

# Install Ansible and dependencies
RUN apt update \
    && apt install -y sudo \
    && /install-ansible.sh \
    && ansible-galaxy install -r /requirements.yml \
    && rm -f /install-ansible.sh /requirements.yml

# Pretend that arma reforger server has been installed
RUN touch /etc/skel/armarserver && chmod +x /etc/skel/armarserver

# Copy entirety of playbooks last so everything above can be cached
WORKDIR /ansible
COPY . /ansible

ENV ARGS="--log-level=emerg"

ENTRYPOINT [ "/docker-entrypoint.sh", "ansible-playbook", "--connection=local", "/ansible/main.yml" ]
