resource "azurerm_public_ip" "application_gateway" {
  name                = "pip-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-01"
  resource_group_name = data.azurerm_resource_group.shared_resource.name
  location            = data.azurerm_resource_group.shared_resource.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
