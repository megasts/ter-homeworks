terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}
resource yandex_mdb_mysql_cluster "mdb_mysql_cluster" {
  name = var.cluster_name
  network_id = var.yandex_vpc_network_id
  environment = "PRESTABLE"
  version = "8.0"
  
  resources {
    resource_preset_id = "b2.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 10

  }
  
  dynamic "host" {
        for_each = var.HA ? var.settings_hosts_ha : [var.settings_hosts_ha.0]
          content {
            zone=host.value.zone
            assign_public_ip=true
          }

  }
}