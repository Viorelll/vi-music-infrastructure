terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-vimusic-shared-plc-04"
    storage_account_name = "stvimusicsharedplc04"
    container_name       = "tfstatevimusicdev"
    key                  = "terraform.tfstate"
    subscription_id      = "8e6b06a1-86b9-42bd-8971-45b0d844b544"
  }
}

provider "azurerm" {
  subscription_id = "8e6b06a1-86b9-42bd-8971-45b0d844b544"
  features {}
}

provider "azurerm" {
  alias           = "shared_connectivity"
  subscription_id = "8e6b06a1-86b9-42bd-8971-45b0d844b544"
  features {}
}

module "environment" {
  source                 = "../modules/environment"
  resource_group_name    = "rg-vimusic-dev-plc-04"
  resource_number        = "04" //change it for other resources
  environment_name       = "dev"
  application_name       = "vimusic"
  region_identifier      = "plc"
  region_full_identifier = "polandcentral"
  aspnetcore_environment = "Development"

  shared_resource_group_name     = "rg-vimusic-shared-plc-04"
  shared_container_registry_name = "crvimusicsharedplc04"

  vnet_name                            = "vnet-vimusic-dev-plc-04"
  vnet_address                         = "10.0.4.0/22" //1024 ip's  //"10.0.0.0/16"
  container_apps_subnet_address_prefix = "10.0.4.0/22"
  api_container_min_replicas           = 1
  api_container_max_replicas           = 1
  api_container_cpu                    = 1
  api_container_memory                 = "2Gi"
  api_http_scale_rules                 = []

  providers = {
    azurerm.shared_connectivity = azurerm.shared_connectivity
  }

  sqldb_auto_pause_delay_in_minutes = 120
  sqldb_sku                         = "B_Standard_B1ms"
  sqldb_min_capacity                = 0.5
  sqldb_admin_username              = "vimusic_admin"
  sqldb_zone_redundant              = false

  app_config_keys = []
}
