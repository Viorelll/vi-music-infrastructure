variable "resource_group_name" {
  type = string
}

variable "application_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "region_identifier" {
  type = string
}

variable "region_full_identifier" {
  type = string
}

variable "aspnetcore_environment" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address" {
  type = string
}

variable "container_apps_subnet_address_prefix" {
  type = string
}

variable "api_container_min_replicas" {
  type = number
}

variable "api_container_max_replicas" {
  type = number
}

variable "api_container_cpu" {
  type = number
}

variable "api_container_memory" {
  type = string
}

variable "api_http_scale_rules" {
  type = list(object({
    name                = string
    concurrent_requests = number
  }))
}

variable "shared_resource_group_name" {
  type = string
}

variable "shared_container_registry_name" {
  type = string
}

variable "sqldb_admin_username" {
  type = string
}

variable "sqldb_sku" {
  type = string
}

variable "sqldb_zone_redundant" {
  type = string
}

variable "sqldb_auto_pause_delay_in_minutes" {
  type = number
}

variable "sqldb_min_capacity" {
  type = number
}

variable "resource_number" {
  type = string
}

variable "app_config_keys" {
  type = list(object({
    key                 = string
    value               = optional(string)
    vault_key_reference = optional(string)
    content_type        = optional(string)
    type                = optional(string)
  }))
}
