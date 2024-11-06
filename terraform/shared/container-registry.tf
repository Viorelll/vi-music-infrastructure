# resource "azurerm_container_registry" "this" {
#   name                = "cr${var.application_name}${var.shared_identifier}${var.region_identifier}02"
#   resource_group_name = data.azurerm_resource_group.shared_resource.name
#   location            = data.azurerm_resource_group.shared_resource.location
#   sku                 = "Basic"
#   admin_enabled       = false
# }
