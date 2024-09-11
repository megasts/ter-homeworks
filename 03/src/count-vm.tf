data "yandex_compute_image" "os_web" {
  family            = var.vm_web.os_family
}

resource "yandex_compute_instance" "vm_web" {
  depends_on        = [yandex_compute_instance.vm_database]
  count             = var.vm_web.vm_count
  name              = "web-${count.index+1}"
  platform_id       = var.vm_web.platform_id
  resources {
    cores           = var.vm_web.cores
    memory          = var.vm_web.memory 
    core_fraction   = var.vm_web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.os_web.image_id
      size          = var.vm_web.disk_volume
      type          = var.vm_web.disk_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_web.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = local.ssh_key_serial_port

}