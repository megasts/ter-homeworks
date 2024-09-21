variable "network_name" {
  type = string
  default = "production"
  description = "VPC network name"
} 

variable "subnet_name" {
  type        = string
  default = "production"
  description = "Subnet name"
}

variable "subnets_data" {
  type = list(object({
    zone = string,
    cidr = string
    }
    )
  )
  default = [ {
    zone = "ru-central1-a", cidr = "10.0.1.0/24"
  } ]
  description = "List data of the zone and cidr" 
}

variable "env_name" {
  type = string
  default = "production"
  description = "prefix name of the subnets"
}