
terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "3.103.1"
      configuration_aliases = [azurerm.shared_connectivity]
    }
  }
}
