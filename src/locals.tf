locals {
  ssh_public_key = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBOy7qsoTojPAztZfNMer2CSn0FwAswJFjTWapwHHX5U terraform hw"


  security_group_ids = [yandex_vpc_security_group.example.id]
}
