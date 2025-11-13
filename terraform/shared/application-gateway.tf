# # USE POST INFRASTRUCTURE RUN BECAUSE IS USED 'SHARED GATEWAY' AND FIRST MUST BE CREATE ENVIRONMENT(S) AND AFTER LINK WITH GATEWAY


# # IMPORT EXISTED RESOURCES
# data "azurerm_container_app_environment" "dev" {
#   provider            = azurerm.dev_subscription
#   resource_group_name = local.dev_resource_group_name
#   name                = local.dev_container_app_environment_name
# }

# data "azurerm_container_app" "api_dev" {
#   provider            = azurerm.dev_subscription
#   resource_group_name = local.dev_resource_group_name
#   name                = local.dev_container_app_name
# }

# data "azurerm_key_vault" "dev_certificates" {
#   provider            = azurerm.dev_subscription
#   name                = "kv${var.application_name}${var.dev_identifier}${var.region_identifier}${var.resource_number}"
#   resource_group_name = local.dev_resource_group_name
# }


## Set roles for Shared Managed Identity (UAI)
#Access for gateway to read keyvault ssl certficate via shared UAI

# resource "azurerm_role_assignment" "shared_uai" {
#   scope                = data.azurerm_key_vault.dev_certificates.id
#   role_definition_name = "Key Vault Certificate User"
#   principal_id         = azurerm_user_assigned_identity.app_gateway_shared.principal_id
# }


# locals {
#   frontend_ip_configuration_name = "default"
#   frontend_port_name             = "https"
#   frontend_port                  = 443

#   api_dev = {
#     probe_name                 = "${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
#     backend_address_pool_name  = "${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
#     backend_http_settings_name = "${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
#     http_listener_name         = "${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
#     ssl_certificate_name       = "${var.application_name}-api-${var.dev_identifier}-${var.region_identifier}-${var.resource_number}"
#   }
# }

# resource "azurerm_application_gateway" "shared" {
#   name                = "agw-${var.application_name}-${var.shared_identifier}-${var.region_identifier}-${var.resource_number}"
#   resource_group_name = data.azurerm_resource_group.shared_resource.name
#   location            = data.azurerm_resource_group.shared_resource.location

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.app_gateway_shared.id]
#   }

#   sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = 1
#   }

#   gateway_ip_configuration {
#     name      = "default"
#     subnet_id = azurerm_subnet.application_gateway.id
#   }

#   frontend_port {
#     name = local.frontend_port_name
#     port = local.frontend_port
#   }

#   frontend_ip_configuration {
#     name                 = local.frontend_ip_configuration_name
#     public_ip_address_id = azurerm_public_ip.application_gateway.id
#   }

#   backend_address_pool {
#     name         = local.api_dev.backend_address_pool_name
#     ip_addresses = [data.azurerm_container_app_environment.dev.static_ip_address]
#   }

#   probe {
#     host                = data.azurerm_container_app.api_dev.ingress[0].fqdn
#     name                = local.api_dev.probe_name
#     protocol            = "Https"
#     path                = "/api"
#     interval            = 30
#     timeout             = 30
#     unhealthy_threshold = 3

#     match {
#       status_code = ["200"]
#     }
#   }

#   backend_http_settings {
#     name                  = local.api_dev.backend_http_settings_name
#     cookie_based_affinity = "Disabled"
#     path                  = "/"
#     port                  = 443
#     protocol              = "Https"
#     request_timeout       = 60

#     host_name  = data.azurerm_container_app.api_dev.ingress[0].fqdn
#     probe_name = local.api_dev.probe_name
#   }


#   http_listener {
#     name                           = local.api_dev.http_listener_name
#     frontend_ip_configuration_name = local.frontend_ip_configuration_name
#     frontend_port_name             = local.frontend_port_name
#     protocol                       = "Https"
#     ssl_certificate_name           = local.api_dev.ssl_certificate_name
#     host_name                      = data.azurerm_static_web_app.dev_vimusic_ui.default_host_name
#   }

#   request_routing_rule {
#     name                       = "${var.application_name}-api-${var.dev_identifier}-${var.resource_number}"
#     rule_type                  = "Basic"
#     http_listener_name         = local.api_dev.http_listener_name
#     backend_address_pool_name  = local.api_dev.backend_address_pool_name
#     backend_http_settings_name = local.api_dev.backend_http_settings_name
#     priority                   = 1
#   }

#   ssl_certificate {
#     name                = local.api_dev.ssl_certificate_name
#     key_vault_secret_id = data.azurerm_key_vault_secret.dev_backend_api_certificate.versionless_id
#   }
# }
