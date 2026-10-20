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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_shared_image_version.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_blob_uri"></a> [blob\_uri](#input\_blob\_uri) | (Optional) The URI of a blob to use as source. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Gallery Image Version. | `bool` | `true` | no |
| <a name="input_end_of_life_date"></a> [end\_of\_life\_date](#input\_end\_of\_life\_date) | (Optional) The end of life date in RFC3339 format. | `string` | `null` | no |
| <a name="input_exclude_from_latest"></a> [exclude\_from\_latest](#input\_exclude\_from\_latest) | (Optional) Exclude this version from being considered latest. Default: false. | `bool` | `false` | no |
| <a name="input_gallery_name"></a> [gallery\_name](#input\_gallery\_name) | (Required) The name of the Shared Image Gallery. DEPENDENCY: Gallery must exist. | `string` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | (Required) The name of the Gallery Image Definition. DEPENDENCY: Image Definition must exist. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Version should exist. | `string` | n/a | yes |
| <a name="input_managed_image_id"></a> [managed\_image\_id](#input\_managed\_image\_id) | (Optional) The ID of the Managed Image to use. DEPENDENCY: Managed Image must exist. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The version number in semantic versioning format (e.g., 1.0.0). | `string` | n/a | yes |
| <a name="input_os_disk_snapshot_id"></a> [os\_disk\_snapshot\_id](#input\_os\_disk\_snapshot\_id) | (Optional) The ID of the OS Disk Snapshot to use. DEPENDENCY: Snapshot must exist. | `string` | `null` | no |
| <a name="input_replication_mode"></a> [replication\_mode](#input\_replication\_mode) | (Optional) Replication mode. Values: Full, Shallow. Default: Full. | `string` | `"Full"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Optional) The Storage Account ID for blob source. DEPENDENCY: Storage Account must exist. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_regions"></a> [target\_regions](#input\_target\_regions) | (Required) List of target regions for replication.<br/>- name: Region name.<br/>- regional\_replica\_count: Number of replicas. Default: 1.<br/>- storage\_account\_type: Storage type. Default: Standard\_LRS.<br/>- disk\_encryption\_set\_id: DES ID for encryption.<br/>- exclude\_from\_latest\_enabled: Exclude from latest in this region. | <pre>list(object({<br/>    name                         = string<br/>    regional_replica_count       = optional(number, 1)<br/>    storage_account_type         = optional(string, "Standard_LRS")<br/>    disk_encryption_set_id       = optional(string, null)<br/>    exclude_from_latest_enabled  = optional(bool, false)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_gallery_name"></a> [gallery\_name](#output\_gallery\_name) | The name of the parent Gallery. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Gallery Image Version. |
| <a name="output_image_name"></a> [image\_name](#output\_image\_name) | The name of the parent Image Definition. |
| <a name="output_name"></a> [name](#output\_name) | The version name. |
| <a name="output_target_regions"></a> [target\_regions](#output\_target\_regions) | The configured target regions. |
<!-- END_TF_DOCS -->