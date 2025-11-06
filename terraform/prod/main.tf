terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatevimusic"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    subscription_id      = "5f222019-262e-4d97-95ab-fe37f46e323d"
  }
}

provider "azurerm" {
  subscription_id            = "5f222019-262e-4d97-95ab-fe37f46e323d"
  skip_provider_registration = true
  features {}
}


module "spoke" {
  source                 = "../modules/spoke"
  resource_group_name    = "rg-vimusicapp-prod-ne"
  environment_name       = "prod"
  application_name       = "vimusicapp"
  region_identifier      = "ne"
  aspnetcore_environment = "Development"

  sqldb_auto_pause_delay_in_minutes = 120
  sqldb_sku                         = "B_Standard_B1ms"
  sqldb_min_capacity                = 0.5
  sqldb_admin_username              = "vimusic_admin"
  sqldb_zone_redundant              = false

  app_config_keys = []
}
