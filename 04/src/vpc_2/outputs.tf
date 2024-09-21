output "yandex_vpc_network" {
  value = yandex_vpc_network.my_network.id
}

output "yandex_vpc_subnet_id" {
  value = [for k in yandex_vpc_subnet.my_subnet : "${k.id}"]
}

output "vpc_subnet_zones" {
  value = [for k in yandex_vpc_subnet.my_subnet : "${k.zone}"]
}