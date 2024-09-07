###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

variable "service_account_key_file" {
  type        = string
  description = "file_key.json"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "count_vm" {
  type = map(any)

  default={  
    vm_count        = 2,
    os_family       = "ubuntu-2004-lts",
    platform_id     = "standard-v2",
    cores           = 2,
    memory          = 0.5,
    core_fraction   = 5,
    preemptible     = true,
    disk_volume     = 10,
    disk_type       = "network-hdd"
  }
}

variable "os_each_vm"{
  type = string
  default = "ubuntu-2004-lts"
}

variable "each_vm" {
  type = list(object({
    instance_name   = string
    platform_id     = string
    cores           = number
    memory          = number
    core_fraction   = number
    preemptible     = bool
    disk_volume     = number
    disk_type       = string
    }))
  
  default =  [
    {  
    instance_name   = "main"
    platform_id     = "standard-v2"
    cores           = 4
    memory          = 1
    core_fraction   = 5
    preemptible     = true
    disk_volume     = 15
    disk_type       = "network-hdd"
    },
    {  
    instance_name   = "replica"
    platform_id     = "standard-v2"
    cores           = 2
    memory          = 0.5
    core_fraction   = 5
    preemptible     = true
    disk_volume     = 10
    disk_type       = "network-hdd"
    }
  ]
}

variable "storage-vm" {
  type = object({
    os_family = string,
    platform_id = string,
    cores = number,
    memory = number,
    core_fraction = number,
    preemptible = bool,
    disk_volume = number,
    disk_type = string})

  default={  
    os_family       = "ubuntu-2004-lts",
    platform_id     = "standard-v2",
    cores           = 2,
    memory          = 0.5,
    core_fraction   = 5,
    preemptible     = true,
    disk_volume     = 10,
    disk_type       = "network-hdd"
  }
}