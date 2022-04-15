resource "yandex_compute_instance" "bastion" {
  count    = var.instance_size_bastion
  name     = "bastion"
  hostname = "bastion"

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tna68ba94tc386qv3"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat_ip_address = var.ip_bastion
    nat       = true
  }
}
