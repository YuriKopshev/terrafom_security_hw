resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
  folder_id = var.folder_id
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  folder_id      = var.folder_id
}