data "yandex_compute_image" "web" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "web_vms" {
  count = 2

  name        = "web-${count.index + 1}"
  platform_id = "standard-v3"



resources {
  cores         = var.vm_web_resources.cores        
  core_fraction = var.vm_web_resources.core_fraction 
  memory        = var.vm_web_resources.memory       
}

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.web.id
      size     = var.vm_web_disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${local.ssh_public_key}"
  }
}

