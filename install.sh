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

# Запускаем команду terraform init (если требуется)
$TERRAFORM_EXECUTABLE init

# Запускаем команду terraform plan с выводом в консоль
$TERRAFORM_EXECUTABLE plan

# Запускаем команду terraform apply с выводом в консоль и подтверждением действия
$TERRAFORM_EXECUTABLE apply -auto-approve


# while true; do
#     if ping -c 1 -W 1 $(terraform output server_ip | sed -e 's/"//g') > /dev/null; then
#         break
#     fi
#     sleep 5
# done
# echo "VM is now available."

export ANSIBLE_HOST=$(terraform output server_ip)
export ANSIBLE_PASSWORD=$(echo $TF_VAR_password)


# Переходим в директорию с playbook'ами Ansible
cd "$ANSIBLE_DIRECTORY" || exit

envsubst < inventory.tpl.yaml > inventory.yaml

ansible-playbook playbook.yml -i inventory.yaml -t server_install

# rm -f inventory.yaml

