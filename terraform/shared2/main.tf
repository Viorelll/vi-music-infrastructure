terraform {
  # required_providers {
  #   azurerm = {
  #     source  = "hashicorp/azurerm"
  #     version = "3.103.1"
  #   }
  # }
  backend "azurerm" {
    resource_group_name  = "rg-viqub-shared-we-01"
    storage_account_name = "stviqubsharedwe02"
    container_name       = "tfstateshared"
    key                  = "terraform.tfstate"
  }
}

# provider "azurerm" {
#   subscription_id = "4547b264-f1ab-4b5a-8e37-fd20926e38eb"
#   features {}
# }

