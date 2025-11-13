# SHARED INFRA IMPORT
data "azurerm_resource_group" "shared_resource" {
  name = local.shared_resource_group_name
}

data "azurerm_user_assigned_identity" "application_gateway" {
  name                = local.shared_managed_identity_name
  resource_group_name = local.shared_resource_group_name
}

data "azurerm_public_ip" "shared_public_ip" {
  name                = "pip-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-${var.resource_number}"
  resource_group_name = local.shared_resource_group_name
}

data "azurerm_subnet" "shared_subnet" {
  name                 = "ApplicationGatewaySubnet"
  virtual_network_name = "vnet-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-${var.resource_number}"
  resource_group_name  = local.shared_resource_group_name
}

# DEV INFRA IMPORT
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


