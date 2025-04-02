#!/bin/bash
set -euo pipefail

echo "🚀 Starting Ansible Deployment Test..."

# Ensure sshpass is installed (needed for --ask-pass)
if ! command -v sshpass &> /dev/null; then
    echo "❌ sshpass is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y sshpass
fi

# Check if Ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y ansible
fi

# Define inventory file location
INVENTORY_FILE="inventory"

# Clear any existing SSH fingerprint
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[127.0.0.1]"

# Run the Ansible playbook
echo "🔧 Running Ansible Playbook..."
ansible-playbook -i "$INVENTORY_FILE" playbook.yml --ask-pass --ask-become-pass

echo "✅ Deployment Complete!"
