# Azure Network Infrastructure with Terraform

A personal Azure Infrastructure as Code lab. The configuration uses a local Terraform module to define a resource group, virtual network, two subnets, and a network security group (NSG). GitHub Actions checks formatting, initializes Terraform, validates the configuration, and generates a plan.

> Personal lab, not a production deployment. Azure charges may apply if resources are created.

## Architecture

```text
Azure Resource Group
└── Virtual Network (10.0.0.0/16)
    ├── Web subnet (configurable CIDR)
    │   └── Network Security Group (allows inbound TCP/80)
    └── Database subnet (configurable CIDR)

Terraform state → Azure Storage backend (existing account/container)
GitHub Actions → fmt → init → validate → plan
```

The storage backend is **not** created by this configuration. Create it first or supply your own backend settings.

## What's in the repository

- `main.tf`: Azure provider, remote backend, and the network module invocation.
- `modules/network/`: resource group, VNet, subnets, and NSG.
- `variables.tf`: network parameters.
- `.github/workflows/terraform-CI.yml`: pull-request and push checks.

## Prerequisites

1. Terraform 1.9 or compatible and an Azure subscription.
2. An Azure identity with the required resource permissions.
3. A pre-existing Azure Storage account and container for Terraform remote state.

## Run locally

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars for your Azure environment.
az login
terraform fmt -check -recursive
terraform init -backend-config="resource_group_name=YOUR_STATE_RG" \
  -backend-config="storage_account_name=YOUR_STATE_STORAGE" \
  -backend-config="container_name=YOUR_STATE_CONTAINER" \
  -backend-config="key=terraform-network.tfstate"
terraform validate
terraform plan
# Only apply after reviewing the plan and Azure cost.
terraform apply
```

**Note:** The current `main.tf` includes lab-specific Azure Storage backend defaults. Override them with your own `-backend-config` parameters. Never commit credentials, Terraform state, or personal `.tfvars` files.

## CI evidence

[Successful Terraform CI run](https://github.com/SunTao2022/terraform-network/actions/runs/31916559397). A successful CI plan is **not** proof that `terraform apply` ran.

## Security and limitations

- The sample NSG permits inbound HTTP (TCP/80) from any source. This is a deliberately simple lab rule, not a production recommendation.
- There is no private endpoint, identity/role setup, policy governance, or end-to-end deployment automation in this example.
- For real deployments, limit NSG source ranges, add least-privilege roles, restrict Terraform state access, and use a production-reviewed network architecture.

## Next improvements

- Add `terraform test`, variable validation, and static security checks.
- Parameterize NSG rules and backend configuration.
- Add a reviewed example using private subnets and Azure Bastion.

## Author

[Tao Sun](https://www.linkedin.com/in/tao-sun-3437462b6/) · [GitHub](https://github.com/SunTao2022)
