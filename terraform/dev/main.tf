terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-vimusic-shared-gwc-01"
    storage_account_name = "stvimusicsharedgwc02"
    container_name       = "tfstatevimusicdev"
    key                  = "terraform.tfstate"
    subscription_id      = "4547b264-f1ab-4b5a-8e37-fd20926e38eb"
  }
}

provider "azurerm" {
  subscription_id = "4547b264-f1ab-4b5a-8e37-fd20926e38eb"
  features {}
}

provider "azurerm" {
  alias           = "shared_connectivity"
  subscription_id = "4547b264-f1ab-4b5a-8e37-fd20926e38eb"
  features {}
}

module "environment" {
  source                 = "../modules/environment"
  resource_group_name    = "rg-vimusic-dev-gwc-01"
  environment_name       = "dev"
  application_name       = "vimusic"
  region_identifier      = "gwc"
  region_full_identifier = "germanywestcentral"
  aspnetcore_environment = "Development"

  shared_resource_group_name     = "rg-vimusic-shared-gwc-01"
  shared_container_registry_name = "crvimusicsharedgwc02"

  vnet_name                            = "vnet-vimusic-dev-gwc-01"
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
