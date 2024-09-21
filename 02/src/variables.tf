###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

# variable "vm_web_cloud_id" {
#   type        = string
#   default     = ""
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
# }

variable "vm_web_folder_id" {
  type        = string
  default     = "b1g8obut7iuv7egloc26"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vm_web_default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_web_default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_web_vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars

# variable "vm_web_vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGK0+6Ztaa7KexL4Z9wNAxpVZJbgzPUY40gukKpM+t1X megion@megion"
#   description = "ssh-keygen -t ed25519"
# }

###netology-develop-platform-...

variable "env" {
  type        = string
  default     = "develop"
  description = "netology-...-...-..."
}

variable "project" {
  type        = string
  default     = "platform"
  description = "netology-...-...-..."
}

variable "vm_role_web" {
  type        = string
  default     = "web"
  description = "netology-...-...-web"
}

###**vms_resources**

variable "vms_resources" {
  type = map(object({
    cores  = number
    memory=number
    core_fraction=number
  }))
  default={
  web = {
    cores=2
    memory=1
    core_fraction=5
    }
  db ={
    cores=2
    memory=2
    core_fraction=20
    }
   }
}

###metadata

 variable "vm_metadata" {
   type = map(object({
     serial-port-enable = number
     ssh-keys = string
   }))
   default={
      metadata = {
       serial-port-enable = 1
       ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGK0+6Ztaa7KexL4Z9wNAxpVZJbgzPUY40gukKpM+t1X megion@megion"
     }
    }
 }

###test
variable "test" {}