

resource "azurerm_container_app_environment" "this" {
  name                           = "cae-${var.application_name}-${var.environment_name}-${var.region_identifier}-${var.resource_number}"
  resource_group_name            = data.azurerm_resource_group.this.name
  location                       = data.azurerm_resource_group.this.location
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  infrastructure_subnet_id       = azurerm_subnet.container_app_environment.id
  internal_load_balancer_enabled = true
}

# Managed identity for container apps
resource "azurerm_user_assigned_identity" "container_apps" {
  location            = data.azurerm_resource_group.this.location
  name                = "ca-${var.application_name}-${var.environment_name}-${var.region_identifier}"
  resource_group_name = data.azurerm_resource_group.this.name
}

# Api container
resource "azurerm_container_app" "api" {
  name                         = "ca-${var.application_name}-api-${var.environment_name}-${var.region_identifier}-${var.resource_number}"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = data.azurerm_resource_group.this.name
  revision_mode                = "Single"

  lifecycle {
    # These things get updated by the ci/cd system when we deploy a new container.
    ignore_changes = [
      template[0].container[0].image
    ]
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_apps.id]
  }

  registry {
    server   = data.azurerm_container_registry.shared.login_server
    identity = azurerm_user_assigned_identity.container_apps.id
  }

  template {
    max_replicas = var.api_container_max_replicas
    min_replicas = var.api_container_min_replicas

    dynamic "http_scale_rule" {
      for_each = { for http_scale_rule in var.api_http_scale_rules : http_scale_rule.name => http_scale_rule }
      content {
        name                = http_scale_rule.value.name
        concurrent_requests = http_scale_rule.value.concurrent_requests
      }
    }

    container {
      name   = "api-${var.resource_number}"
      image  = "mcr.microsoft.com/k8se/quickstart:latest" # "${data.azurerm_container_registry.shared.login_server}/monolith-backend-api:latest" # Point to ACR image ### Manual changes (done outside of terraform) are ingored. No need to change this line.
      cpu    = var.api_container_cpu
      memory = var.api_container_memory

      env {
        name  = "AZURE_CLIENT_ID" # Required for user assigned managed identity
        value = azurerm_user_assigned_identity.container_apps.client_id
      }

      env {
        name  = "AppConfigEndpoint"
        value = azurerm_app_configuration.this.endpoint
      }

      env {
        name  = "ASPNETCORE_ENVIRONMENT"
        value = var.aspnetcore_environment
      }
    }
  }

  ingress {
    allow_insecure_connections = false
    target_port                = 80
    external_enabled           = true # Since it's an internal environment, we only allow access from the vnet.

    traffic_weight {
      percentage      = 100
      latest_revision = true
      label           = "latest"
    }
  }

  # depends_on = [azurerm_role_assignment.container_apps_container_registry]
}
