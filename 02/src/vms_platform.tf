variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop_zone_b"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vm_db_vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGK0+6Ztaa7KexL4Z9wNAxpVZJbgzPUY40gukKpM+t1X megion@megion"
  description = "ssh-keygen -t ed25519"
}
