resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["${var.vnet_ip_address}/22"]
  location            = data.azurerm_resource_group.shared_resource.location
  resource_group_name = data.azurerm_resource_group.shared_resource.name
}

resource "azurerm_subnet" "application_gateway" {
  name                 = "ApplicationGatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.shared_resource.name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["${var.vnet_ip_address}/24"]

  depends_on = [azurerm_virtual_network.vnet]
}
