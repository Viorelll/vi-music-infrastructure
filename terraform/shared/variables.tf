variable "application_name" {
  type    = string
  default = "vimusic"
}

variable "region_identifier" {
  type    = string
  default = "plc"
}

variable "shared_identifier" {
  type    = string
  default = "shared"
}

variable "dev_identifier" {
  type    = string
  default = "dev"
}

variable "vnet_name" {
  type    = string
  default = "vnet-vimusic-shared-plc-01"
}

variable "vnet_ip_address" {
  type    = string
  default = "10.0.20.0"
}

locals {
  shared_resource_group_name  = "rg-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-01"
  shared_storage_account_name = "st${var.application_name}${var.shared_identifier}${var.region_identifier}02"

  # dev_resource_group_name            = "rg-${var.application_name}-${var.dev_identifier}-${var.region_identifier}-01"
  # dev_container_app_environment_name = "cae-${var.application_name}-${var.dev_identifier}-${var.region_identifier}-01"
  # dev_container_app_name             = "ca-${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-01"
}
