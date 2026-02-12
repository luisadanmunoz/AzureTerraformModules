# Azure Automation Certificate Module

Terraform module to create and manage **Azure Automation Certificates** for secure certificate storage and usage in runbooks.

## Features

- Store PFX certificates securely in Azure Automation
- Multiple certificates in a single module call
- Password-protected certificates support
- Exportable/non-exportable configuration
- Certificate thumbprint and expiry date outputs
- Conditional creation with `create = true/false`

## Usage - Single Certificate

```hcl
module "automation_certificate" {
  source = "path/to/Automation/AutomationCertificate"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  certificates = {
    "MyCertificate" = {
      base64      = filebase64("./certs/mycert.pfx")
      password    = var.cert_password
      description = "Certificate for API authentication"
      exportable  = false
    }
  }
}
```

## Usage - Multiple Certificates

```hcl
module "automation_certificates" {
  source = "path/to/Automation/AutomationCertificate"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  certificates = {
    "AzureRunAsCertificate" = {
      base64      = filebase64("./certs/runas.pfx")
      password    = var.runas_cert_password
      description = "Run As certificate for Azure authentication"
      exportable  = true
    }
    "APIGatewayCert" = {
      base64      = filebase64("./certs/api-gateway.pfx")
      password    = var.api_cert_password
      description = "Certificate for API Gateway mTLS"
      exportable  = false
    }
    "CodeSigningCert" = {
      base64      = filebase64("./certs/codesigning.pfx")
      password    = var.signing_cert_password
      description = "Code signing certificate"
      exportable  = false
    }
  }
}
```

## Usage - From Key Vault

```hcl
data "azurerm_key_vault_certificate" "api_cert" {
  name         = "api-certificate"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "api_cert_password" {
  name         = "api-certificate-password"
  key_vault_id = data.azurerm_key_vault.main.id
}

module "automation_certificates" {
  source = "path/to/Automation/AutomationCertificate"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  certificates = {
    "APICertificate" = {
      base64      = data.azurerm_key_vault_certificate.api_cert.certificate_data_base64
      password    = data.azurerm_key_vault_secret.api_cert_password.value
      description = "API certificate from Key Vault"
      exportable  = false
    }
  }
}
```

## Using Certificates in Runbooks

### PowerShell

```powershell
# Get certificate by name
$cert = Get-AutomationCertificate -Name "MyCertificate"

# Use certificate for web request with client certificate
$uri = "https://api.example.com/endpoint"
Invoke-RestMethod -Uri $uri -Certificate $cert -Method Get

# Get certificate thumbprint
$thumbprint = $cert.Thumbprint
Write-Output "Certificate thumbprint: $thumbprint"

# Check expiration
$expiryDate = $cert.NotAfter
Write-Output "Certificate expires: $expiryDate"
```

### Python

```python
import automationassets
from OpenSSL import crypto

# Get certificate
cert_data = automationassets.get_automation_certificate("MyCertificate")

# Load certificate
cert = crypto.load_pkcs12(cert_data, password)
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the certificates | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `certificates` | Map of certificates to create | `map(object)` | `{}` | no |

### Certificate Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `base64` | Base64-encoded PFX certificate content | `string` | yes |
| `password` | Password for the PFX certificate (sensitive) | `string` | no |
| `description` | Description of the certificate | `string` | no |
| `exportable` | Whether the certificate is exportable | `bool` | no (default: true) |

## Outputs

| Name | Description |
|------|-------------|
| `certificate_ids` | Map of certificate names to their IDs |
| `certificate_names` | List of created certificate names |
| `certificate_thumbprints` | Map of certificate names to their thumbprints |
| `certificate_expiry_dates` | Map of certificate names to their expiry dates |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist before creating certificates

## Security Notes

- Certificate content and passwords are marked as sensitive
- Use `exportable = false` for production certificates when possible
- Consider storing certificates in Key Vault and referencing them
- Monitor certificate expiry dates and renew before expiration
- Private keys are stored encrypted in Azure Automation
