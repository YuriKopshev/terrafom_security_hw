###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

### VM vars для задания 2
variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    ram          = number
    disk_volume  = number
  }))
  default = [
    {
      vm_name      = "main"
      cpu          = 2
      ram          = 4
      disk_volume  = 32
    },
    {
      vm_name      = "replica"
      cpu          = 2
      ram          = 4
      disk_volume  = 16
    }
  ]
  description = "Параметры ВМ для баз данных (main и replica)"
}

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "VM DB image family"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "VM Web image family"
}

variable "security_group_ids" {
  type        = list(string)
  description = "ID группы безопасности из задания 1"
}