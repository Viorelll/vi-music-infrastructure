terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-vimusic-shared-plc-01"
    storage_account_name = "stvimusicsharedplc02"
    container_name       = "tfstateshared"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "8e6b06a1-86b9-42bd-8971-45b0d844b544"
  features {}
}

provider "azurerm" {
  alias           = "dev_subscription"
  subscription_id = "8e6b06a1-86b9-42bd-8971-45b0d844b544"
  features {}
}

