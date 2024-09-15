terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstateviqub"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    subscription_id      = "5f222019-262e-4d97-95ab-fe37f46e323d"
    use_oidc             = true
    client_id            = "3eff7aae-2d36-441e-b1bd-66d85ac0486d"
    tenant_id            = "0801ae25-cd3e-47b8-be89-59091b6a29b1"
  }
}

provider "azurerm" {
  subscription_id = "5f222019-262e-4d97-95ab-fe37f46e323d"
  features {}
}

# resource "rg-viqubapp-dev-ne" "example" {
#   name     = "rg-viqubapp-dev-ne"
#   location = "ne"
# }


module "spoke" {
  source                 = "../modules/spoke"
  resource_group_name    = "rg-viqubapp-dev-ne"
  environment_name       = "dev"
  application_name       = "viqubapp"
  region_identifier      = "ne"
  aspnetcore_environment = "Development"

  sqldb_auto_pause_delay_in_minutes = 120
  sqldb_sku                         = "B_Standard_B1ms"
  sqldb_min_capacity                = 0.5
  sqldb_admin_username              = "viqub_admin"
  sqldb_zone_redundant              = false

  app_config_keys = []
}
