resource "yandex_compute_instance" "rancher" {
  name     = "rancher"
  hostname = "rancher"

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
      image_id = data.yandex_compute_image.ubuntu_image.id
      size = "20"
      type = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet.id
    nat       = false
  }
}