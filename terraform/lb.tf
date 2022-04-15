resource "yandex_lb_target_group" "project_app_tg" {
  name      = "project-app-tg"
  region_id = "ru-central1"

  dynamic target {
    for_each = yandex_compute_instance.ingress.*.network_interface.0.ip_address
    content {
      subnet_id = yandex_vpc_subnet.private-subnet.id
      address   = target.value
    }
  }
}

resource "yandex_lb_network_load_balancer" "project_app_lb" {
  name = "project-app-lb"

  listener {
    name        = "project-app-listener"
    port        = 80
    target_port = 30080
    external_address_spec {
      #address = var.ip_loadbalancer
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.project_app_tg.id

    healthcheck {
      name = "app-port-hc"
      tcp_options {
        port = 30080
      }
    }
  }

}