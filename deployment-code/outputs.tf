output "platform_landing_zone_id" {
  value = azurerm_management_group.platform_landing_zone.id
}

output "application_landing_zone_id" {
  value = azurerm_management_group.application_landing_zone.id
}

output "application_landing_zone_children_ids" {
  description = "Map of child management group name (ID) to its resource ID."
  value       = { for k, v in azurerm_management_group.app_lz_children : k => v.id }
}

output "subscription_id" {
  value = azurerm_subscription.this.subscription_id
}

output "subscription_alias_resource_id" {
  value = azurerm_subscription.this.id
}
