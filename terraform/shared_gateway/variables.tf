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

variable "resource_number" {
  type    = string
  default = "03"
}

locals {
  shared_resource_group_name   = "rg-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-${var.resource_number}"
  shared_managed_identity_name = "agw-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-${var.resource_number}"

  dev_resource_group_name            = "rg-${var.application_name}-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
  dev_container_app_environment_name = "cae-${var.application_name}-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
  dev_container_app_name             = "ca-${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
  dev_ssl_cert_name                  = "${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
}
