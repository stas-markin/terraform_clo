terraform {
  required_providers {
    clo = {
      source = "clo-ru/clo"
      version = "1.0.7"
    }
  }
}

provider "clo" {
  # Configuration options
  auth_url = "https://api.clo.ru"
  token = var.token
}

# Получаем список проектов
data "clo_projects" "all_projects" {
}

locals  {
  pr_id = data.clo_projects.all_projects.results[0].id
}


# Получаем ID образа операционной системы. Имя образа берем из переменных.
data "clo_project_image" "ubuntu" {
  project_id = local.pr_id
  name = var.os_name
}

# Создаем VM
resource "clo_compute_instance" "myserv" {
  project_id = local.pr_id
  name = "my_server"
  password = var.password
  flavor_ram = 2
  flavor_vcpus = 1
  image_id = data.clo_project_image.ubuntu.image_id
  block_device {
    bootable = true
    storage_type = "volume"
    size = 10
  }
  addresses {
    version = 4
    external = true
    ddos_protection = false
  }
}

# Получаем список всех ip-адресов в проекте
data "clo_network_ips" "all_addresses" {
  project_id = local.pr_id
}

# Наш внешний IP
output "server_ip" {
  value = length(data.clo_network_ips.all_addresses.results) > 0 ? data.clo_network_ips.all_addresses.results[0].address : null
}
