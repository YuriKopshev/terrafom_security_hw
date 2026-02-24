data "yandex_compute_image" "web" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "web_vms" {
  count = 2

  name        = "web-${count.index + 1}"
  platform_id = "standard-v3"
  

  #depends_on = [yandex_compute_instance.db_vms]

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.web.id
      size      = 10
    }
  }

network_interface {
  subnet_id          = yandex_vpc_subnet.develop.id
  security_group_ids = local.security_group_ids  
  nat                = true
}

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${local.ssh_public_key}"
  }
}

