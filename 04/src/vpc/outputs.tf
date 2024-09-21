output "yandex_vpc_network" {
  value = yandex_vpc_network.my_network.id
}

output "yandex_vpc_subnet" {
  value = yandex_vpc_subnet.my_subnet.id
}

output "vpc_subnet_zones" {
  value = var.subnet_zone
}