terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "4547b264-f1ab-4b5a-8e37-fd20926e38eb"
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "vitest-example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "vitestexamplestoracc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "vitestcontent"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
