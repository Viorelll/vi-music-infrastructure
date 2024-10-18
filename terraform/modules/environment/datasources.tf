data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_container_registry" "shared" {
  provider            = azurerm.shared_connectivity
  name                = var.shared_container_registry_name
  resource_group_name = var.shared_resource_group_name
}
