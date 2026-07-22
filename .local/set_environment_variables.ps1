#!/usr/bin/env pwsh

$Repo = "RajarshiDawn/organization"

$Vars = @{
    TF_VAR_platform_landing_zone_name            = "mg-platform-landing-zone"
    TF_VAR_platform_landing_zone_display_name    = "Platform Landing Zone"
    TF_VAR_application_landing_zone_name         = "mg-application-landing-zone"
    TF_VAR_application_landing_zone_display_name = "Application Landing Zone"
    TF_VAR_application_landing_zone_children     = '{"mg-corporate-apps":"Corporate Apps","mg-online-apps":"Online Apps","mg-local-apps":"Local Apps","mg-sandbox":"Sandbox","mg-decommissioned":"Decommissioned"}'
    TF_VAR_subscription_name                     = "sub-centrallogginsvcs-prod"
    TF_VAR_alias_name                            = "sub-centrallogginsvcs-prod-01"
    TF_VAR_billing_scope_id                      = "/providers/Microsoft.Billing/billingAccounts/RajarshiDawn/billingProfiles/Platform services/invoiceSections/Logging Services"
    TF_VAR_workload                              = "Production"
    TF_VAR_tags                                  = '{"department":"CMG","application":"Platform","environment":"Prod"}'
}

foreach ($Name in $Vars.Keys) {
    Write-Host "Setting $Name..."
    gh variable set $Name --body $Vars[$Name] --repo $Repo
}

Write-Host "Done."


terraform init `
    -backend-config="resource_group_name=rg-cendepsvcs-eus-01" `
    -backend-config="storage_account_name=sacendepsvcseus01" `
    -backend-config="container_name=cendepsvcsremotestatefile" `
    -backend-config="key=organization.tfstate"