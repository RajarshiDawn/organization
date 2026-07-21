# --- Platform Landing Zone ---
variable "platform_landing_zone_name" {
  description = "Management group name (ID) for Platform Landing Zone."
  type        = string
}

variable "platform_landing_zone_display_name" {
  description = "Display name for Platform Landing Zone."
  type        = string
}

# --- Application Landing Zone ---
variable "application_landing_zone_name" {
  description = "Management group name (ID) for Application Landing Zone."
  type        = string
}

variable "application_landing_zone_display_name" {
  description = "Display name for Application Landing Zone."
  type        = string
}

# --- Children under Application Landing Zone ---
variable "application_landing_zone_children" {
  description = "Map of management group name (ID) => display name for groups nested under Application Landing Zone."
  type        = map(string)
}

# --- Subscription ---
variable "subscription_name" {
  description = "Display name of the new subscription, as it will appear in the Azure portal."
  type        = string
}

variable "alias_name" {
  description = "Alias name for the subscription. Changing this forces a new subscription to be created."
  type        = string
}

variable "billing_scope_id" {
  description = "Full Azure Billing Scope ID for the target Invoice Section."
  type        = string
}

variable "workload" {
  description = "Workload type for the subscription. Possible values: 'Production' or 'DevTest'."
  type        = string

  validation {
    condition     = contains(["Production", "DevTest"], var.workload)
    error_message = "workload must be either 'Production' or 'DevTest'."
  }
}

variable "tags" {
  description = "Tags to apply to the subscription."
  type        = map(string)
}