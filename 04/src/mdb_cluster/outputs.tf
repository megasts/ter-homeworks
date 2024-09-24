output "yandex_mdb_mysql_cluster_id" {
  value = yandex_mdb_mysql_cluster.mdb_mysql_cluster.id
}

# output "yandex_vpc_subnet_id" {
#   value = [for k in yandex_vpc_subnet.my_subnet : "${k.id}"]
# }

# output "vpc_subnet_zones" {
#   value = [for k in yandex_vpc_subnet.my_subnet : "${k.zone}"]
# }