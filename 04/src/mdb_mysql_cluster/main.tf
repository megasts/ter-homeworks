resource yandex_mdb_mysql_cluster "mdb_mysql_cluster" {
  name = "test"
  network_id =  module.network.yandex_vpc_network
  environment = "PRESTABLE"
  version = "8.0"
  
  resources {
    resource_preset_id = "b2.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 10

  }

 dynamic "host" {
        for_each = toset(module.network.yandex_vpc_subnet_id)
            content {
                 zone      = module.network.vpc_subnet_zones[host.key]
#                 subnet_id = module.network.yandex_vpc_subnet_id[host.key]
            }
 }

  # host { 
  #   zone      = module.network.vpc_subnet_zones[0]
  #   subnet_id = module.network.yandex_vpc_subnet_id[0]
  # } 

  # host {
  #   zone      = module.network.vpc_subnet_zones[1]
  #   subnet_id = module.network.yandex_vpc_subnet_id[1]
  # } 
  
  # host {
  #   zone      = module.network.vpc_subnet_zones[2]
  #   subnet_id = module.network.yandex_vpc_subnet_id[2]
  # } 
}

module "network" {
  source = "/home/megion/Projects/ter-homeworks/ter-homeworks/04/src/vpc_2"
  subnets_data = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
    { zone = "ru-central1-a", cidr = "10.0.4.0/24" },
  ]
  
}
resource "yandex_vpc_network" "develop" {
  name = var.vpc_network_name
}

resource "yandex_vpc_subnet" "develop" {
  count = length(var.subnets_data)
  name           = "${var.vpc_network_name}-${count.index+1}"
  zone           = "ru-central1-a"
  network_id     = var.yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
