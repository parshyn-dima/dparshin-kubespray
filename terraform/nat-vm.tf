resource "yandex_compute_instance" "nat-vm" {
  name     = "nat-vm"
  hostname = "nat-vm"

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
}
