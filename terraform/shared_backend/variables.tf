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

locals {
  shared_resource_group_name = "rg-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-01"
}
