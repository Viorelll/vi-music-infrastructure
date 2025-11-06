#Link App Gateway backend pool after app is created
# resource "azurerm_application_gateway_backend_address_pool_address" "dev_backend" {
#   application_gateway_name  = "agw-vimusic-shared-plc-01"
#   backend_address_pool_name = "${var.application_name}-api-dev-${var.region_identifier}-01"
#   resource_group_name       = var.shared_resource_group_name

#   fqdn = data.azurerm_container_app.api_dev_01.ingress[0].fqdn
# }


# resource "null_resource" "update_backend_pool" {
#   provisioner "local-exec" {
#     command = <<EOT
#       az network application-gateway address-pool update \
#         --gateway-name "agw-vimusic-shared-plc-01" \
#         --resource-group rg-vimusic-shared-plc-01 \
#         --name "vimusic-api-dev-plc-01 \
#         --servers "74.248.144.6"
#     EOT
#   }
# }
