#!/bin/bash

# perform system updates
sudo apt update -y
sudo apt upgrade -y

# install necessary packages
sudo apt install epel-release -y
sudo apt install ansible -y
sudo apt install git -y

# download ansible playbooks
git clone https://github.com/delatvan/ansible.git # get ansible pbs from github (they're gonna be public)
cd ansible

# check for the inventory.ini existence
read -p "Press Enter to confirm you have created the inventory.ini in the ansible folder"

# run standalone playbook for ssh keys
ansible-playbook -i inventory.ini setup_ssh_keys.yml --ask-become-pass

# add keys to github
read -p "Press Enter to confirm you have added the newly generated keys to github..."

# The script will pause here until the user presses Enter
echo "Continuing the script execution..."

eval "$(ssh-agent)"
ssh-add ~/.ssh/id_ed25519_$(hostname)
ansible-playbook -i inventory.ini master_playbook.yml --ask-become-pass

# working