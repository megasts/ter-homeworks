terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_network" "my_network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "my_subnet" {
  v4_cidr_blocks = var.cidr
  zone           = var.subnet_zone
  network_id     = "${yandex_vpc_network.my_network.id}"
  name = var.subnet_name
}