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
| [azurerm_container_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_containers"></a> [containers](#input\_containers) | List of containers to deploy in the container group. | <pre>list(object({<br/>    name   = string<br/>    image  = string<br/>    cpu    = number<br/>    memory = number<br/>    ports = optional(list(object({<br/>      port     = number<br/>      protocol = optional(string, "TCP")<br/>    })), [])<br/>    environment_variables        = optional(map(string), {})<br/>    secure_environment_variables = optional(map(string), {})<br/>    commands                     = optional(list(string), [])<br/>    volume_mounts = optional(list(object({<br/>      name       = string<br/>      mount_path = string<br/>      read_only  = optional(bool, false)<br/>    })), [])<br/>    liveness_probe = optional(object({<br/>      exec                  = optional(list(string))<br/>      http_get_path         = optional(string)<br/>      http_get_port         = optional(number)<br/>      http_get_scheme       = optional(string)<br/>      initial_delay_seconds = optional(number, 0)<br/>      period_seconds        = optional(number, 10)<br/>      failure_threshold     = optional(number, 3)<br/>      success_threshold     = optional(number, 1)<br/>      timeout_seconds       = optional(number, 1)<br/>    }))<br/>    readiness_probe = optional(object({<br/>      exec                  = optional(list(string))<br/>      http_get_path         = optional(string)<br/>      http_get_port         = optional(number)<br/>      http_get_scheme       = optional(string)<br/>      initial_delay_seconds = optional(number, 0)<br/>      period_seconds        = optional(number, 10)<br/>      failure_threshold     = optional(number, 3)<br/>      success_threshold     = optional(number, 1)<br/>      timeout_seconds       = optional(number, 1)<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostics configuration for the container group. | <pre>object({<br/>    log_analytics = object({<br/>      workspace_id  = string<br/>      workspace_key = string<br/>      log_type      = optional(string, "ContainerInsights")<br/>      metadata      = optional(map(string), {})<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_dns_name_label"></a> [dns\_name\_label](#input\_dns\_name\_label) | The DNS label/name for the container group's public IP (if public). Must be unique within the Azure region. | `string` | `null` | no |
| <a name="input_dns_name_label_reuse_policy"></a> [dns\_name\_label\_reuse\_policy](#input\_dns\_name\_label\_reuse\_policy) | The DNS name label reuse policy. Possible values are Unsecure, TenantReuse, SubscriptionReuse, ResourceGroupReuse, or Noreuse. | `string` | `"Unsecure"` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS servers for the container group. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_exposed_ports"></a> [exposed\_ports](#input\_exposed\_ports) | List of ports to expose on the container group level. | <pre>list(object({<br/>    port     = number<br/>    protocol = optional(string, "TCP")<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the container group. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_image_registry_credential"></a> [image\_registry\_credential](#input\_image\_registry\_credential) | Image registry credentials for pulling container images. | <pre>list(object({<br/>    server                    = string<br/>    username                  = optional(string)<br/>    password                  = optional(string)<br/>    user_assigned_identity_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_init_containers"></a> [init\_containers](#input\_init\_containers) | List of init containers to run before the main containers. | <pre>list(object({<br/>    name                         = string<br/>    image                        = string<br/>    environment_variables        = optional(map(string), {})<br/>    secure_environment_variables = optional(map(string), {})<br/>    commands                     = optional(list(string), [])<br/>    volume_mounts = optional(list(object({<br/>      name       = string<br/>      mount_path = string<br/>      read_only  = optional(bool, false)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The IP address type. Possible values are Public, Private, or None. | `string` | `"None"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Container Instance will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container Group. If not provided, will be generated from naming variables. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Container Group name. | `string` | `"ci"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type for the container group. Possible values are Linux and Windows. | `string` | `"Linux"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority of the container group. Possible values are Regular and Spot. | `string` | `"Regular"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Container Instance will be created. | `string` | n/a | yes |
| <a name="input_restart_policy"></a> [restart\_policy](#input\_restart\_policy) | The restart policy for the container group. Possible values are Always, Never, OnFailure. | `string` | `"Always"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU for the container group. Possible values are Standard and Dedicated. | `string` | `"Standard"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the container group (for Private IP address type). | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | List of volumes to mount to the container group. | <pre>list(object({<br/>    name                 = string<br/>    mount_path           = string<br/>    read_only            = optional(bool, false)<br/>    empty_dir            = optional(bool, false)<br/>    storage_account_name = optional(string)<br/>    storage_account_key  = optional(string)<br/>    share_name           = optional(string)<br/>    secret               = optional(map(string))<br/>    git_repo = optional(object({<br/>      url       = string<br/>      directory = optional(string)<br/>      revision  = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the Container Group (if public IP with DNS label). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container Group. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the Container Group. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The IP address of the Container Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Container Group. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system assigned identity (if enabled). |
<!-- END_TF_DOCS -->