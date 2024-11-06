# variable "application_name" {
#   type    = string
#   default = "viqub"
# }

# variable "region_identifier" {
#   type    = string
#   default = "we"
# }

# variable "shared_identifier" {
#   type    = string
#   default = "shared"
# }

# variable "dev_identifier" {
#   type    = string
#   default = "dev"
# }

# locals {
#   shared_resource_group_name  = "rg-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-01"
#   shared_storage_account_name = "st${var.application_name}${var.shared_identifier}${var.region_identifier}02"

#   dev_resource_group_name            = "rg-${var.application_name}-${var.dev_identifier}-${var.region_identifier}-01"
#   dev_container_app_environment_name = "cae-${var.application_name}-${var.dev_identifier}-${var.region_identifier}-01"
#   dev_container_app_name             = "ca-${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-01"
# }


variable "client_id" {
  description = "The client ID of the Azure Service Principal"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "The client secret of the Azure Service Principal"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID of the Azure account"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "The subscription ID of the Azure account"
  type        = string
  sensitive   = true
}


variable "access_key" {
  description = "Azure storage account access key"
  type        = string
  sensitive   = true
}
