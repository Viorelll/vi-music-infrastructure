resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address]
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_subnet" "container_app_environment" {
  name                                          = "ContainerAppEnvironmentSubnet"
  resource_group_name                           = data.azurerm_resource_group.this.name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = [var.container_apps_subnet_address_prefix]
  private_link_service_network_policies_enabled = false
}
