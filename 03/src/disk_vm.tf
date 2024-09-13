resource "yandex_compute_disk" "storage" {
  count     = 3
  name      = "disk-${count.index}"
  type      = "network-hdd"
  size      = 1
}

data "yandex_compute_image" "os_storage" {
  family            = var.vm_storage.os_family
}

resource "yandex_compute_instance" "vm_storage"{
    name        = var.vm_storage.name
    platform_id = var.vm_storage.platform_id
    resources {
        cores           = var.vm_storage.cores
        memory          = var.vm_storage.memory 
        core_fraction   = var.vm_storage.core_fraction
    }
    boot_disk {
        initialize_params {
            image_id      = data.yandex_compute_image.os_storage.image_id
            size          = var.vm_storage.disk_volume
            type          = var.vm_storage.disk_type
        }
    }
    scheduling_policy {
        preemptible = var.vm_storage.preemptible
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        #security_group_ids = [yandex_vpc_security_group.example.id]
        nat       = false
    }

    metadata = local.ssh_key_serial_port

    
    dynamic "secondary_disk"{
        for_each = "${yandex_compute_disk.storage}"
            content {
                 disk_id = lookup(secondary_disk.value, "id", "null")
                 device_name =  lookup(secondary_disk.value, "name", "null")
            }
    }  
}