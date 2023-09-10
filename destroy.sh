#!/bin/bash

# Путь к исполняемому файлу Terraform
TERRAFORM_EXECUTABLE="/usr/bin/terraform"

# Путь к директории, содержащей конфигурационные файлы Terraform
TERRAFORM_DIRECTORY="./terraform/"

# Переходим в директорию с файлами Terraform
cd "$TERRAFORM_DIRECTORY" || exit

# Запускаем команду terraform destroy с подтверждением действия
$TERRAFORM_EXECUTABLE destroy -auto-approve