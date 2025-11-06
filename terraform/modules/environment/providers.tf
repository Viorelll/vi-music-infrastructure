
terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "4.51.0"
      configuration_aliases = [azurerm.shared_connectivity]
    }
  }
}
