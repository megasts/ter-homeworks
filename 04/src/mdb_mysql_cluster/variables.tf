###cloud vars

variable "service_account_key_file" {
  type        = string
  description = "file_key.json"
}

variable "folder_id" {
  type        = string
  description = "ID of the folder that the resource belongs to"
}

variable "vpc_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "The zones field is an array of your availability zones"
}


variable "vpc_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "A list of blocks of internal IPv4 addresses that are owned by this subnet"
}

# variable "cidr_zone_a" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }
# variable "cidr_zone_b" {
#   type        = list(string)
#   default     = ["10.0.2.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

variable "vpc_network_name" {
  type        = string
  default     = "develop"
  description = "Name of the network"
}

variable "vpc_subnet_name" {
  type        = string
  default     = "develop"
  description = "Name of the subnet"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "ssh-keygen -t ed25519"
}

variable "prefix_vm" {
  type        = string
  default     = "netology-project"
  description = "example vm_db_ prefix"
}

variable "username" {
  type = string
  default = "ubuntu"
  description = "for ubuntu"
}

variable "image_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "OS type"
}

variable "project_marketing" {
  type = string
  default = "marketing"
  description = "Name of the project"
}

variable "project_analytics" {
  type = string
  default = "analytics"
  description = "Name of the project"
}

variable  "subnets_data" {
  type = list(object({
    zone = string,
    cidr = string
    }
    )
  )
  default = [ {
    zone = "ru-central1-a", cidr = "10.0.1.0/24"
  } ] 
}

variable "settings_hosts_ha" {
  type = set(object({
    zone = string
    name = string
  }))
  default = [
    {
        zone = "ru-central1-a"
        name = string
    },
    {
        zone = "ru-central1-b"
        name = string
    }
  ]
}

variable "HA" {
  type = bool
  default = true
}
