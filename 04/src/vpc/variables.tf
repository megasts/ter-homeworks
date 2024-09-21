variable "network_name" {
  type = string
  default = "develop"
  description = "VPC network name"
} 

variable "cidr" {
    type = list(string)
    default = ["10.0.1.0/24"]
    description = "A list of blocks of internal IPv4 addresses that are owned by this subnet."
}

variable "subnet_zone" {
    type = string
    default = "ru-central1-a"
    description = "Name of the Yandex.Cloud zone for this subnet."
    validation {
      condition = contains(["ru-central1-a", "ru-central1-b"], var.subnet_zone)
      error_message = "Invalid zone. Platform standard-v1 not working in 'ru-central1-b' "
    }
}

variable "subnet_name" {
  type        = string
  default = "develop"
  description = "Subnet name"
}