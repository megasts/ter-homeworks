output "vm_platform_info" {
value = [
["vm_web", 
"instance_name: ${yandex_compute_instance.platform-web.name}", 
"external_ip: ${yandex_compute_instance.platform-web.network_interface.0.nat_ip_address}", 
"fqdn: ${yandex_compute_instance.platform-web.fqdn}"],
[
"vm_db", 
"instance_name: ${yandex_compute_instance.platform-db.name}", 
"external_ip: ${yandex_compute_instance.platform-db.network_interface.0.nat_ip_address}", 
"fqdn: ${yandex_compute_instance.platform-db.fqdn}"
]
]
description = "vm_platform_info"
}