data "azurerm_resource_group" "shared_resource" {
  name = local.shared_resource_group_name
}

data "azurerm_storage_account" "shared_storage" {
  name                = local.shared_storage_account_name
  resource_group_name = local.shared_resource_group_name
}


data "azurerm_user_assigned_identity" "application_gateway" {
  name                = local.shared_managed_identity_name
  resource_group_name = local.shared_resource_group_name
}

data "azurerm_subnet" "application_gateway" {
  name                 = "ApplicationGatewaySubnet"
  virtual_network_name = local.shared_vnet_name
  resource_group_name  = local.shared_resource_group_name
}

data "azurerm_public_ip" "application_gateway" {
  name                = local.shared_public_name
  resource_group_name = local.shared_resource_group_name
}

data "azurerm_container_app_environment" "dev_01" {
  provider            = azurerm.dev_subscription
  resource_group_name = local.dev_resource_group_name
  name                = local.dev_container_app_environment_name
}

data "azurerm_container_app" "api_dev_01" {
  provider            = azurerm.dev_subscription
  resource_group_name = local.dev_resource_group_name
  name                = local.dev_container_app_name
}

