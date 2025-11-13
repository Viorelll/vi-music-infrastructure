# ### ASSIGN KEY VAULT ADMINISTRATOR & APP CONFIGURATION DATA OWNER FOR TERRAFORM APPLY USER (LOCAL SIGN IN USER/TERRAFORM APP REGISTRATION)
# ### ASSIGN THIS ROLES IS POSSIBLE IF TERRAFORM APP REGISTRATION IS OWNER IN KEY_VALUT/APP_CONFIG


# ## Set roles for Shared Managed Identity (UAI)
# #Access for gateway to read keyvault ssl certficate via shared UAI
# resource "azurerm_role_assignment" "shared_uai" {
#   scope                = data.azurerm_key_vault.dev_certificates.id
#   role_definition_name = "Key Vault Certificate User"
#   principal_id         = azurerm_user_assigned_identity.app_gateway_shared.principal_id
# }
