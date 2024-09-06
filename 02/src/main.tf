resource "yandex_vpc_network" "develop" {
  folder_id      = var.vm_web_folder_id
  name           = var.vm_web_vpc_name
}
resource "yandex_vpc_subnet" "develop-web" {
  folder_id      = var.vm_web_folder_id
  name           = var.vm_web_vpc_name
  zone           = var.vm_web_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_web_default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "develop-db" {
  folder_id      = var.vm_web_folder_id
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = var.vm_web_folder_id
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  folder_id      = var.vm_web_folder_id
  name       = "test-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "platform-web" {
  name        = local.vm_name_web
  platform_id = "standard-v2"
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-web.id
    nat       = false
  }

  # metadata = {
  #   serial-port-enable = 1
  #   ssh-keys           = "ubuntu:${var.vm_web_vms_ssh_root_key}"
  # }
  metadata = var.vm_metadata.metadata
}

resource "yandex_compute_instance" "platform-db" {
  name        = local.vm_name_db
  platform_id = "standard-v2"
  zone = var.vm_db_default_zone
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-db.id
    nat       = false
  }

  # metadata = {
  #   serial-port-enable = 1
  #   ssh-keys = "ubuntu:${var.vm_db_vms_ssh_root_key}"
  # }
  metadata = var.vm_metadata.metadata
}
