data "azurerm_resource_group" "shared_resource" {
  name = local.shared_resource_group_name
}

data "azurerm_storage_account" "shared_storage" {
  name                = local.shared_storage_account_name
  resource_group_name = local.shared_resource_group_name
}


# USE POST INFRASTRUCTURE RUN BECAUSE IS USED 'SHARED GATEWAY' AND FIRST MUST BE CREATE ENVIRONMENT(S) AND AFTER LINK WITH GATEWAY

data "azurerm_container_app_environment" "dev" {
  provider            = azurerm.dev_subscription
  resource_group_name = local.dev_resource_group_name
  name                = local.dev_container_app_environment_name
}

data "azurerm_container_app" "api_dev" {
  provider            = azurerm.dev_subscription
  resource_group_name = local.dev_resource_group_name
  name                = local.dev_container_app_name
}

data "azurerm_key_vault" "dev_certificates" {
  provider            = azurerm.dev_subscription
  name                = "kv${var.application_name}${var.dev_identifier}${var.region_identifier}${var.resource_number}"
  resource_group_name = local.dev_resource_group_name
}

data "azurerm_key_vault_secret" "dev_backend_api_certificate" {
  provider     = azurerm.dev_subscription
  name         = local.dev_ssl_cert_name
  key_vault_id = data.azurerm_key_vault.dev_certificates.id
}

data "azurerm_static_web_app" "dev_vimusic_ui" {
  name                = "stapp-${var.application_name}-${var.dev_identifier}-${var.region_identifier}"
  resource_group_name = local.dev_resource_group_name
}
