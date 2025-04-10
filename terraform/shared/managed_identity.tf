# Managed identity for app gateway
resource "azurerm_user_assigned_identity" "app_gateway_dev" {
  location            = data.azurerm_resource_group.shared_resource.location
  name                = "agw-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-01"
  resource_group_name = data.azurerm_resource_group.shared_resource.name
}
