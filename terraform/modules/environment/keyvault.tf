resource "azurerm_key_vault" "this" {
  name                = "kv${var.application_name}${var.environment_name}${var.region_identifier}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "random_password" "sqldb_admin_password" {
  length           = 16
  special          = true
  override_special = "!#*()-_+?"
}

resource "azurerm_key_vault_secret" "sqldb_admin_password" {
  name         = "sqldb-admin-password"
  key_vault_id = azurerm_key_vault.this.id
  value        = random_password.sqldb_admin_password.result

  depends_on = [azurerm_role_assignment.terraform_keyvault_admin] #wait until the role for creating new secret will be assigned
}

resource "azurerm_key_vault_secret" "sqldb_connection_string_viqupapp" {
  name         = "sqldb-connectionstring"
  key_vault_id = azurerm_key_vault.this.id
  value        = "Server=${azurerm_postgresql_flexible_server.server.fqdn};Database=${azurerm_postgresql_flexible_server_database.db.name};Port=5432;User Id=${var.sqldb_admin_username};Password=${azurerm_postgresql_flexible_server.server.administrator_password};Ssl Mode=Require;"

  depends_on = [azurerm_role_assignment.terraform_keyvault_admin] #wait until the role for creating new secret will be assigned
}

resource "azurerm_key_vault_certificate" "https_cert" {
  name         = "generated-cert"
  key_vault_id = azurerm_key_vault.this.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = ["${azurerm_static_web_app.vimusic_ui.default_host_name}"]
      }

      subject            = "CN=vimusic"
      validity_in_months = 12
    }
  }
}
