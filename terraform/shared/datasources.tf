data "azurerm_resource_group" "shared_resource" {
  name = local.shared_resource_group_name
}

data "azurerm_storage_account" "shared_storage" {
  name                = local.shared_storage_account_name
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

