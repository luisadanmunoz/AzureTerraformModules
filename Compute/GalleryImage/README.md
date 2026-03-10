# GalleryImage

Terraform module for creating Gallery Image Definitions.

## Features

- Linux and Windows support
- Gen1 and Gen2 Hyper-V
- Trusted Launch and Confidential VM
- Recommended vCPU/memory specs
- Specialized image support

## Usage

```hcl
module "image_definition" {
  source = "./Compute/GalleryImage"

  resource_group_name = "rg-images-prod-001"
  location            = "westeurope"
  gallery_name        = module.gallery.name
  name                = "ubuntu-2204-hardened"

  os_type            = "Linux"
  hyper_v_generation = "V2"

  identifier = {
    publisher = "MyOrg"
    offer     = "Ubuntu"
    sku       = "22.04-LTS-Hardened"
  }

  trusted_launch_enabled = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gallery_name | Parent gallery name | `string` | n/a | yes |
| name | Image definition name | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| identifier | Publisher/Offer/SKU | `object` | n/a | yes |
| hyper_v_generation | V1 or V2 | `string` | `"V2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Image Definition ID |
| name | Image Definition name |
