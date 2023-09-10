#!/bin/bash

# Путь к исполняемому файлу Terraform
TERRAFORM_EXECUTABLE="/usr/bin/terraform"

# Путь к директории, содержащей конфигурационные файлы Terraform
TERRAFORM_DIRECTORY="./terraform/"

# Путь к исполняемому файлу Ansible
ANSIBLE_EXECUTABLE="/usr/local/bin/ansible-playbook"

# Путь к директории с playbook'ами Ansible
ANSIBLE_DIRECTORY="../ansible/"

# Переходим в директорию с файлами Terraform
cd "$TERRAFORM_DIRECTORY" || exit

export ANSIBLE_HOST=$(terraform output server_ip)
export ANSIBLE_PASSWORD=$(echo $TF_VAR_password)


# Переходим в директорию с playbook'ами Ansible
cd "$ANSIBLE_DIRECTORY" || exit

envsubst < inventory.tpl.yaml > inventory.yaml

ansible-playbook playbook.yml -i inventory.yaml -t client_install -e 'client_name=stas_laptop'