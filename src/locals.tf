locals {
  ssh_public_key = "ubuntu:${file("${path.module}/keys/id_ed25519_yc.pub")}"
}
