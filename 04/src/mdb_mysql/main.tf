terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}
resource yandex_mdb_mysql_database "mdb_mysql" {
  cluster_id = var.cluster_id
  name = var.name_db
}

resource "yandex_mdb_mysql_user" "mysql_user" {
  cluster_id = var.cluster_id
  name = var.user_db
  password = "megionDB"
  permission {
    database_name = var.name_db
    roles         = ["ALL"]
  }
  
}