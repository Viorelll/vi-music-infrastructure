resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${var.application_name}-${var.environment_name}-${var.region_identifier}-${var.resource_number}"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
}

resource "azurerm_application_insights" "this" {
  name                = "appi-${var.application_name}-${var.environment_name}-${var.region_identifier}-${var.resource_number}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
}
