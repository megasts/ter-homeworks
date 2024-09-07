resource "yandex_compute_disk" "storage" {
  count     = 3
  name      = "disk-${count.index}"
  type      = "network-hdd"
  size      = 1
}

data "yandex_compute_image" "os_storage-vm" {
  family            = var.storage-vm.os_family
}

resource "yandex_compute_instance" "storage-vm"{
    name        = "storage"
    platform_id = var.storage-vm.platform_id
    resources {
        cores           = var.storage-vm.cores
        memory          = var.storage-vm.memory 
        core_fraction   = var.storage-vm.core_fraction
    }
    boot_disk {
        initialize_params {
            image_id      = data.yandex_compute_image.os_storage-vm.image_id
            size          = var.storage-vm.disk_volume
            type          = var.storage-vm.disk_type
        }
    }
    scheduling_policy {
        preemptible = var.storage-vm.preemptible
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        #security_group_ids = [yandex_vpc_security_group.example.id]
        nat       = true
    }

    metadata = local.ssh_key_serial_port

    
    dynamic "secondary_disk"{
        for_each = "${yandex_compute_disk.storage.*.id}"
            content {
                disk_id = yandex_compute_disk.storage["${secondary_disk.key}"].id
            }
    }  
}