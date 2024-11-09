resource "azurerm_app_configuration" "this" {
  name                = "appcs-${var.application_name}-${var.environment_name}-${var.region_identifier}-01"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  sku                 = "standard"
}

resource "azurerm_app_configuration_key" "app_config_keys" {
  for_each = { for app_config_key in var.app_config_keys : app_config_key.key => app_config_key }

  configuration_store_id = azurerm_app_configuration.this.id
  key                    = each.value.key
  value                  = each.value.value
  vault_key_reference    = each.value.vault_key_reference
  content_type           = each.value.content_type
  type                   = each.value.type
}

# resource "azurerm_app_configuration_key" "db_connection_string" {
#   configuration_store_id = azurerm_app_configuration.this.id
#   key                    = "ConnectionStrings:PostgresConnection"
#   vault_key_reference    = azurerm_key_vault_secret.sqldb_connection_string_viqupapp.versionless_id
#   type                   = "vault"
# }
