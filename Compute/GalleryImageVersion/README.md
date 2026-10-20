# GalleryImageVersion

Terraform module for creating Gallery Image Versions.

## Features

- Multi-region replication
- Managed image or snapshot source
- Disk encryption per region
- End of life date
- Exclude from latest

## Usage

```hcl
module "image_version" {
  source = "./Compute/GalleryImageVersion"

  resource_group_name = "rg-images-prod-001"
  location            = "westeurope"
  gallery_name        = module.gallery.name
  image_name          = module.image_definition.name
  name                = "1.0.0"

  managed_image_id = azurerm_image.golden.id

  target_regions = [
    {
      name                   = "westeurope"
      regional_replica_count = 2
      storage_account_type   = "Standard_LRS"
    },
    {
      name                   = "northeurope"
      regional_replica_count = 1
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gallery_name | Parent gallery | `string` | n/a | yes |
| image_name | Parent image definition | `string` | n/a | yes |
| name | Version (semantic) | `string` | n/a | yes |
| managed_image_id | Source image ID | `string` | `null` | no |
| target_regions | Replication targets | `list(object)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Image Version ID |
| name | Version name |
