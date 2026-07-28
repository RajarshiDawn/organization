terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}
}

# --- Discover the Tenant Root Group ---
data "azurerm_client_config" "current" {}

data "azurerm_management_group" "tenant_root" {
  name = data.azurerm_client_config.current.tenant_id
}

# --- Top-level Landing Zones under Tenant Root ---
resource "azurerm_management_group" "platform_landing_zone" {
  name                       = var.platform_landing_zone_name
  display_name               = var.platform_landing_zone_display_name
  parent_management_group_id = data.azurerm_management_group.tenant_root.id
}

resource "azurerm_management_group" "application_landing_zone" {
  name                       = var.application_landing_zone_name
  display_name               = var.application_landing_zone_display_name
  parent_management_group_id = data.azurerm_management_group.tenant_root.id
}

# --- Children under Application Landing Zone ---
resource "azurerm_management_group" "app_lz_children" {
  for_each = var.application_landing_zone_children

  name                       = each.key
  display_name               = each.value
  parent_management_group_id = azurerm_management_group.application_landing_zone.id
}

# --- Subscription, created against the given invoice section scope ---
resource "azurerm_subscription" "this" {
  subscription_name = var.subscription_name
  alias             = var.alias_name
  billing_scope_id  = var.billing_scope_id
  workload          = var.workload
  tags              = var.tags
}

# --- Associate the newly created subscription & existing subscription with the Platform Landing Zone ---
resource "azurerm_management_group_subscription_association" "assc_logging_subscription" {
  management_group_id = azurerm_management_group.platform_landing_zone.id
  subscription_id     = "/subscriptions/${azurerm_subscription.this.subscription_id}"
}

resource "azurerm_management_group_subscription_association" "assc_deployment_subscription" {
  management_group_id = azurerm_management_group.platform_landing_zone.id
  subscription_id     = var.dep_svcs_subs_name
}
