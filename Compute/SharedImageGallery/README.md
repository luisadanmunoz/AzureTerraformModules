# SharedImageGallery

Terraform module for creating Azure Shared Image Galleries (Azure Compute Gallery).

## Features

- Private, Groups, or Community sharing
- Community gallery with EULA and publisher info
- Custom descriptions
- Conditional creation

## Usage

```hcl
module "gallery" {
  source = "./Compute/SharedImageGallery"

  resource_group_name = "rg-images-prod-001"
  location            = "westeurope"

  workload    = "golden"
  environment = "prod"

  description = "Golden images for production workloads"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Gallery name | `string` | `null` | no |
| description | Description | `string` | `null` | no |
| sharing | Sharing config | `object` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Gallery ID |
| name | Gallery name |
| unique_name | Unique gallery name |
