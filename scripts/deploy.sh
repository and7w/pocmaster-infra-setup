#!/bin/bash
# Initialiser Terraform
cd terraform
terraform init
terraform apply -auto-approve

# Récupérer l'IP publique de l'instance
INSTANCE_IP=$(terraform output -raw ec2_public_ip)

# Générer l'inventaire Ansible
echo "[servers]" > ../ansible/inventories/production
echo "$INSTANCE_IP" >> ../ansible/inventories/production

# Exécuter les playbooks Ansible
cd ../ansible
ansible-playbook playbooks/common.yml
ansible-playbook playbooks/setup-vault.yml
ansible-playbook playbooks/setup-nexus.yml
ansible-playbook playbooks/setup-argocd.yml
