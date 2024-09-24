terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
#  token     = var.token
  service_account_key_file = file("${var.service_account_key_file}")
#  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.vpc_zone
}

module "net" {
  source = "../vpc_2" 
}

module "cluster" {
  depends_on = [ module.net ]
  source = "../mdb_cluster"
  HA = var.HA
  cluster_name = var.cluster_name
  yandex_vpc_network_id = module.net.yandex_vpc_network
}

module "MYSQL_DB" {
  depends_on = [ module.cluster ]
  source = "../mdb_mysql"
  cluster_id = module.cluster.yandex_mdb_mysql_cluster_id
  name_db = var.name_db
  user_db = var.user_db
  
}