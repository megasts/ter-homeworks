terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = "~>1.8.4" #Требуемая версия terraform
}

/*для подключения к docker по SSH надо сначала выдайте себе права на docker: 
sudo usermod -aG docker $USER 
*/ 

provider "docker" {
  host     = "ssh://ubuntu@89.169.133.115:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "random_password" "random_string1" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "random_string2" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysqlimage" {
  name         = "mysql:8.0"
  keep_locally = true
}

resource "docker_container" "mysql1" {
  image = docker_image.mysqlimage.image_id
  name  = "mysql1"
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.random_string1.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.random_string2.result}",  
    "MYSQL_ROOT_HOST=%",    
  ]
}

