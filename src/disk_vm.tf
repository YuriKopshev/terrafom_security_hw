
resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name     = "storage-disk-${count.index + 1}"
  type     = "network-ssd"
  zone     = var.default_zone
  size     = 8  # 8 gb
  block_size = 4096
  image_id = data.yandex_compute_image.web.id  
}


data "yandex_compute_image" "storage" {
  family = var.vm_web_image_family
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.storage.id
      size      = 10
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


  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks  
    content {
      disk_id = secondary_disk.value.id
      auto_delete = true
    }
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${local.ssh_public_key}"
  }
}
