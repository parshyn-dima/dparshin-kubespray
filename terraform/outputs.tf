output "external_ip_address_bastion" {
  value = yandex_compute_instance.bastion.*.network_interface.0.nat_ip_address
}

output "internal_ip_address_nodes" {
  value = yandex_compute_instance.node.*.network_interface.0.ip_address
}

output "internal_ip_address_master" {
  value = yandex_compute_instance.master.*.network_interface.0.ip_address
}

output "internal_ip_address_ingress" {
  value = yandex_compute_instance.ingress.*.network_interface.0.ip_address
}