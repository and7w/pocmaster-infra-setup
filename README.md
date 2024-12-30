# pocmaster-infra-setup

## install terraform
## install ansible

ansible-playbook -i inventories/00_inventory.yml playbooks/setup-nexus.yml --tags service
