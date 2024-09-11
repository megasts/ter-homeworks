data "yandex_compute_image" "os_database" {
  family            = var.os_db
}

resource "yandex_compute_instance" "vm_database" {
  for_each          = {for vm in var.vm_db[*]: "${vm.instance_name}" => vm}
  name              = each.value.instance_name
  platform_id       = each.value.platform_id
  resources {
    cores           = each.value.cores
    memory          = each.value.memory 
    core_fraction   = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.os_database.image_id
      size          = each.value.disk_volume
      type          = each.value.disk_type
    }
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  #  security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = local.ssh_key_serial_port

}