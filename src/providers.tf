terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = "b1gusqav4did0h05n4dn"
  folder_id                = "b1gg6es4g1ca783mhsk4"
  zone                     = var.default_zone
  service_account_key_file = "/Users/yuri_kopshev/authorized_key.json"
}

output "security_group_id" {
  value = yandex_vpc_security_group.example.id
}
