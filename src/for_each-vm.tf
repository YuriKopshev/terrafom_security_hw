data "yandex_compute_image" "db" {
  family = var.vm_db_image_family
}

resource "yandex_compute_instance" "db_vms" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = "standard-v3"
  
  resources {
    cores         = each.value.cpu
    core_fraction = 20
    memory        = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.db.id
      size      = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id  
    security_group_ids = var.security_group_ids
    nat                = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${local.ssh_public_key}"
  }
}
