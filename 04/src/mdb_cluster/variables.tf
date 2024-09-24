variable "cluster_name" {
  type = string
  default = "test"
  description = "Name of the cluster"
}

variable "yandex_vpc_network_id" {
  type        = string
  description = "Network ID"
}

variable "settings_hosts_ha" {
  type = list(object({
    zone = string})
  )
  default = [
    {
        zone = "ru-central1-a"
    },
    {
        zone = "ru-central1-a"
    },
  ]
}

variable "HA" {
  type = bool
  default = true
  description = "High-Availability(HA) Cluster true=On/false=Off"
}
