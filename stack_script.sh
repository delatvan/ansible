#!/bin/bash

# perform system updates
apt update -y
apt upgrade -y

# install necessary packages
apt install epel-release -y
apt install ansible -y

# download ansible playbooks
wget https://git@github.com:delatvan/ansible.git # get ansible pbs from github (they're gonna be public)

# run standalone playbook for ssh keys
ansible-playbook -i inventory.ini setup_ssh_keys.yml --ask-become-pass

# add keys to github
read -p "Press Enter to confirm you have added the newly generated keys to github..."

# The script will pause here until the user presses Enter
echo "Continuing the script execution..."

eval "$(ssh-agent)"
ssh-add ~/.ssh/id_ed25519_$(hostname)
ansible-playbook -i inventory.ini master_playbook.yml --ask-become-pass