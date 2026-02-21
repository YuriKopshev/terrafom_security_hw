resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tpl", {
    web_vms  = yandex_compute_instance.web_vms
    db_vms   = yandex_compute_instance.db_vms  
    storage  = yandex_compute_instance.storage
  })
  filename = "${path.module}/../inventory/hosts"
}