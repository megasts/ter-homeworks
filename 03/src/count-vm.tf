data "yandex_compute_image" "os_count-vm" {
  family            = var.count_vm.os_family
}

resource "yandex_compute_instance" "count-vm" {
  depends_on        = [yandex_compute_instance.each-vm]
  count             = var.count_vm.vm_count
  name              = "web-${count.index+1}"
  platform_id       = var.count_vm.platform_id
  resources {
    cores           = var.count_vm.cores
    memory          = var.count_vm.memory 
    core_fraction   = var.count_vm.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.os_count-vm.image_id
      size          = var.count_vm.disk_volume
      type          = var.count_vm.disk_type
    }
  }

  scheduling_policy {
    preemptible = var.count_vm.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = local.ssh_key_serial_port

}