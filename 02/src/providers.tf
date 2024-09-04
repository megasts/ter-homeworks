terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.vm_web_cloud_id
  folder_id                = var.vm_web_folder_id
  zone                     = var.vm_web_default_zone
  service_account_key_file = file("~/.ssh/authorized_key.json")
}
