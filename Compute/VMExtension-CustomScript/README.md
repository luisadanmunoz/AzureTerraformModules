# VMExtension-CustomScript

Terraform module for deploying Custom Script Extension on Azure VMs.

## Features

- Linux and Windows support
- Inline commands or script files
- Download scripts from URLs or Storage Blobs
- Managed Identity authentication for private blobs

## Usage

### Inline Command

```hcl
module "custom_script" {
  source = "./Compute/VMExtension-CustomScript"

  virtual_machine_id = module.vm.id
  os_type            = "Linux"

  command_to_execute = "apt-get update && apt-get install -y nginx"
}
```

### Script from URL

```hcl
module "custom_script" {
  source = "./Compute/VMExtension-CustomScript"

  virtual_machine_id = module.vm.id
  os_type            = "Windows"

  file_uris = [
    "https://raw.githubusercontent.com/org/repo/main/setup.ps1"
  ]
  command_to_execute = "powershell -ExecutionPolicy Unrestricted -File setup.ps1"
}
```

### Private Blob with Managed Identity

```hcl
module "custom_script" {
  source = "./Compute/VMExtension-CustomScript"

  virtual_machine_id = module.vm.id
  os_type            = "Linux"

  file_uris = [
    "https://mystorageaccount.blob.core.windows.net/scripts/install.sh"
  ]
  command_to_execute         = "bash install.sh"
  managed_identity_client_id = module.vm.identity[0].principal_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| command_to_execute | Command to run | `string` | `null` | no |
| file_uris | Script URLs | `list(string)` | `[]` | no |
| storage_account_name | Storage account | `string` | `null` | no |
| storage_account_key | Storage key | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| name | Extension name |
