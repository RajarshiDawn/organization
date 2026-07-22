# Azure Landing Zone — Subscription Deployment

## What this does

This repository provisions new Azure subscriptions and places them into the correct position within an organization's management group hierarchy, aligning each subscription with its intended landing zone (platform or application workload) and billing scope.

## How it works

- **Infrastructure as Code**: Subscription creation and placement are defined declaratively using Terraform, ensuring deployments are repeatable, version-controlled, and reviewable before they take effect.
- **Automated deployment pipeline**: Changes are deployed through a CI/CD workflow that plans and applies infrastructure changes automatically, with review gates before production changes are applied.
- **Passwordless authentication**: The pipeline authenticates to the cloud provider using workload identity federation, meaning no long-lived secrets or credentials are stored or managed — trust is established dynamically between the CI/CD platform and the cloud identity provider for each deployment run.
- **Environment-based promotion**: Deployments are scoped to specific environments, allowing controls such as required approvals to be applied before changes reach production.
- **Structured hierarchy**: New subscriptions are organized under a management group structure that separates shared platform services from individual application workloads, making policy, access, and cost management consistent across the environment.

## Outcome

The result is a consistent, auditable way to onboard new subscriptions into the environment without manual portal steps or shared credentials — every subscription's placement, billing association, and configuration is defined in code and deployed through an automated, reviewed pipeline.
