variable "application_name" {
  type    = string
  default = "viqub"
}

variable "region_identifier" {
  type    = string
  default = "we"
}

variable "shared_identifier" {
  type    = string
  default = "shared"
}

locals {
  shared_resource_group_name = "rg-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-01"
}
