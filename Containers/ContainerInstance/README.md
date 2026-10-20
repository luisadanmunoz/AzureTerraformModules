# ContainerInstance (Azure Container Instances)

Terraform module for Azure Container Instances (ACI).

## Features

- Linux and Windows containers
- Multiple containers per group
- Init containers support
- Public, Private, or no IP address
- Volume mounts (Azure Files, emptyDir, secrets, git repo)
- Health probes (liveness and readiness)
- Private registry authentication
- Managed identity support
- Log Analytics integration
- Spot instances support

## Usage

### Basic Container

```hcl
module "container" {
  source = "./Containers/ContainerInstance"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "webapp"
  environment = "dev"

  containers = [
    {
      name   = "nginx"
      image  = "nginx:latest"
      cpu    = 0.5
      memory = 0.5
      ports = [
        {
          port     = 80
          protocol = "TCP"
        }
      ]
    }
  ]

  ip_address_type = "Public"
  dns_name_label  = "my-webapp-dev"

  exposed_ports = [
    {
      port     = 80
      protocol = "TCP"
    }
  ]
}
```

### Multi-container with Sidecar

```hcl
module "container" {
  source = "./Containers/ContainerInstance"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "api"
  environment = "prod"

  containers = [
    {
      name   = "api"
      image  = "myregistry.azurecr.io/api:v1.0"
      cpu    = 1.0
      memory = 1.5
      ports = [
        { port = 8080, protocol = "TCP" }
      ]
      environment_variables = {
        "APP_ENV" = "production"
      }
      liveness_probe = {
        http_get_path   = "/health"
        http_get_port   = 8080
        http_get_scheme = "Http"
        period_seconds  = 30
      }
    },
    {
      name   = "envoy"
      image  = "envoyproxy/envoy:v1.28-latest"
      cpu    = 0.5
      memory = 0.5
      ports = [
        { port = 80, protocol = "TCP" }
      ]
    }
  ]

  ip_address_type = "Public"

  exposed_ports = [
    { port = 80, protocol = "TCP" }
  ]

  identity = {
    type = "SystemAssigned"
  }
}
```

### Private Container with ACR

```hcl
module "container" {
  source = "./Containers/ContainerInstance"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "worker"
  environment = "prod"

  containers = [
    {
      name   = "worker"
      image  = "myregistry.azurecr.io/worker:v1.0"
      cpu    = 2.0
      memory = 4.0
      environment_variables = {
        "QUEUE_CONNECTION" = "..."
      }
    }
  ]

  ip_address_type = "Private"
  subnet_ids      = [azurerm_subnet.aci.id]

  image_registry_credential = [
    {
      server                    = "myregistry.azurecr.io"
      user_assigned_identity_id = azurerm_user_assigned_identity.acr_pull.id
    }
  ]

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.acr_pull.id]
  }
}
```

### With Azure Files Volume

```hcl
module "container" {
  source = "./Containers/ContainerInstance"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "storage"
  environment = "dev"

  containers = [
    {
      name   = "app"
      image  = "myapp:latest"
      cpu    = 1.0
      memory = 1.0
      volume_mounts = [
        {
          name       = "data"
          mount_path = "/data"
        }
      ]
    }
  ]

  volumes = [
    {
      name                 = "data"
      mount_path           = "/data"
      storage_account_name = azurerm_storage_account.main.name
      storage_account_key  = azurerm_storage_account.main.primary_access_key
      share_name           = azurerm_storage_share.data.name
    }
  ]

  ip_address_type = "None"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| containers | List of containers | `list(object)` | n/a | yes |
| name | Container group name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| os_type | Linux or Windows | `string` | `"Linux"` | no |
| restart_policy | Always, Never, OnFailure | `string` | `"Always"` | no |
| ip_address_type | Public, Private, None | `string` | `"None"` | no |
| dns_name_label | DNS label for public IP | `string` | `null` | no |
| sku | Standard or Dedicated | `string` | `"Standard"` | no |
| priority | Regular or Spot | `string` | `"Regular"` | no |
| subnet_ids | Subnet IDs for private IP | `list(string)` | `[]` | no |
| image_registry_credential | Registry credentials | `list(object)` | `[]` | no |
| identity | Managed identity config | `object` | `null` | no |
| volumes | Volume configurations | `list(object)` | `[]` | no |
| diagnostics | Log Analytics config | `object` | `null` | no |
| init_containers | Init containers | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Container Group ID |
| name | Container Group name |
| ip_address | Container Group IP address |
| fqdn | FQDN (if public with DNS label) |
| identity | Identity configuration |
| principal_id | System assigned identity principal ID |

## Notes

- ACI is best for simple containerized workloads
- For complex orchestration, consider AKS
- Private IP requires subnet delegation to Microsoft.ContainerInstance/containerGroups
- Spot instances can be interrupted with 30 seconds notice
