terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Déclaration des variables utilisées dans terraform.tfvars
variable "mysql_root_password" {
  type = string
}

variable "mysql_database" {
  type = string
}

variable "mysql_user" {
  type = string
}

variable "mysql_host" {
  type    = string
  default = "mysql"
}

variable "mysql_port" {
  type    = number
  default = 3306
}

# Réseau interne Docker
resource "docker_network" "internal_network" {
  name = "internal_network"
}

# Image MySQL
resource "docker_image" "mysql" {
  name = "mysql:9.2"
}

# Conteneur MySQL
resource "docker_container" "mysql" {
  name  = var.mysql_host
  image = docker_image.mysql.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]

  ports {
    internal = 3306
    external = 3306
  }

  volumes {
    host_path      = "${abspath(path.module)}/sqlfiles"
    container_path = "/docker-entrypoint-initdb.d"
  }

  networks_advanced {
    name = docker_network.internal_network.name
  }
}

# Image Python API
resource "docker_image" "python-api" {
  name         = "python-api"
  keep_locally = true

  build {
    context    = "${path.module}/server_python/api"
    dockerfile = "Dockerfile"
  }
}

# Conteneur Python API
resource "docker_container" "python-api" {
  name  = "python-api"
  image = docker_image.python-api.image_id

  ports {
    internal = 8000
    external = 8000
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PORT=${var.mysql_port}",
    "MYSQL_HOST=${var.mysql_host}"
  ]

  networks_advanced {
    name = docker_network.internal_network.name
  }

  restart = "always"

  depends_on = [docker_container.mysql]
}
