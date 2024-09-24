variable "cluster_id" {
  type = string
  description = "Cluster ID"
}


variable "name_db" {
  type = string
  default = "test_db"
  description = "Name of the MYSQL DB"
}

variable "user_db" {
  type = string
  default = "test_user"
  description = "Name of the user MYSQL DB"
}
