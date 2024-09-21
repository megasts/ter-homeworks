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
  count =  length(var.subnets_data)
  v4_cidr_blocks = ["${var.subnets_data[count.index].cidr}"]
  zone           = "${var.subnets_data[count.index].zone}"
  network_id     = "${yandex_vpc_network.my_network.id}"
  name = "${var.env_name}-${count.index+1}"
}