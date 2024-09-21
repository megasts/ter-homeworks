
module "vpc" {
  source = "./vpc"
  cidr = var.vpc_subnet_cidr
  subnet_zone = var.vpc_zone
  network_name = var.vpc_network_name
  subnet_name = var.vpc_subnet_name
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.prefix_vm 
  network_id     = module.vpc.yandex_vpc_network
  subnet_zones   = [module.vpc.vpc_subnet_zones]
  subnet_ids     = [module.vpc.yandex_vpc_subnet]
  instance_name = var.project_marketing
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true

  labels = { 
    owner= var.username,
    project = var.project_marketing     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.prefix_vm
  network_id     = module.vpc.yandex_vpc_network
  subnet_zones   = [module.vpc.vpc_subnet_zones]
  subnet_ids     = [module.vpc.yandex_vpc_subnet]
  instance_name  = var.project_analytics
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true

  labels = { 
    owner= var.username,
    project = var.project_analytics
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.username
    ssh_public_key     = file(var.vms_ssh_root_key)
#    packages           = jsonencode(var.packages)
  }
}