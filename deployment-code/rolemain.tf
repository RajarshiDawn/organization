module "plat_log_ingestion_policy_identity_role" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-authorization-roleassignment.git?ref=8f90a2110e81def1c63f8f81f44e60554793e50e"

  role_assignments_azure_resource_manager = {
    (var.plat_log_ingestion_policy_identity_rolename) = {
      principal_object_id = azurerm_management_group_policy_assignment.activity_log_to_law.identity[0].principal_id
      role_id             = var.plat_log_ingestion_policy_identity_roleid
      scope               = azurerm_management_group.platform_landing_zone.id
    }
  }
}
