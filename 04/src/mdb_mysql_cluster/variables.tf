
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

variable "cluster_name" {
  type = string
  default = "test"
  description = "Name of the cluster"
}

variable "name_db" {
  type = string
  default = "test_db"
  description = "Name of the MYSQL DB"
}

variable "user_db" {
  type = string
  default = "test_user"
  description = "Name of the user MYSQL DB pw megionDB" 
}

variable "HA" {
  type = bool
  default = true
  description = "High-Availability(HA) Cluster true=On/false=Off"
}