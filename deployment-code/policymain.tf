resource "azurerm_management_group_policy_assignment" "activity_log_to_law" {
  name                 = var.plat_logingestion_policy_name
  management_group_id  = azurerm_management_group.platform_landing_zone.id
  policy_definition_id = var.plat_act_logingestion_poldef_id
  location             = var.plat_logingestion_policy_location

  parameters = jsonencode({
    logAnalytics = { value = var.plat_central_logworkspace_id }
  })

  identity {
    type = "SystemAssigned"
  }
}
