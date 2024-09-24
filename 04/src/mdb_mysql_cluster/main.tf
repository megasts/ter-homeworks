# resource yandex_mdb_mysql_cluster "mdb_mysql_cluster" {
#   name = var.cluster_name
#   network_id = module.net.yandex_vpc_network
#   # network_id =  yandex_vpc_network.develop.id
#   environment = "PRESTABLE"
#   version = "8.0"
  
#   resources {
#     resource_preset_id = "b2.medium"
#     disk_type_id       = "network-hdd"
#     disk_size          = 10

#   }
  
#   dynamic "host" {
#         for_each = var.HA ? var.settings_hosts_ha : [var.settings_hosts_ha.0]
#           content {
#             zone=host.value.zone
#           }

#   }
#  dynamic "host" {
#         for_each = yandex_vpc_subnet.develop

#             content { 
#                  zone       = host.value.zone
#                  subnet_id  = host.value.id
#                  name       = host.value.description
#             }
#  }
# }

# resource "yandex_vpc_network" "develop" {
# #  name = "${var.prefix_vpc_net}-network"
# }

# resource "yandex_vpc_subnet" "develop" {
#   count = var.HA ? length(var.settings_hosts_ha) : 1
#   name           = "${var.prefix_vpc_net}-subnet-${count.index+1}"
#   zone           = var.settings_hosts_ha[count.index].zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.settings_hosts_ha[count.index].cidr
#   description    = var.settings_hosts_ha[count.index].name
# }
