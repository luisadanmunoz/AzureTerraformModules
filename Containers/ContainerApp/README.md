# ContainerApp (Azure Container Apps)

Terraform module for Azure Container Apps.

## Features

- Single or Multiple revision mode
- Auto-scaling with various scale rules (HTTP, TCP, Queue, Custom)
- Ingress with traffic splitting
- Dapr integration
- Init containers
- Volume mounts
- Health probes (liveness, readiness, startup)
- Key Vault secrets integration
- Managed identity support
- Private registry authentication

## Usage

### Basic Web App

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "webapp"
  environment = "dev"

  template = {
    min_replicas = 1
    max_replicas = 5

    containers = [
      {
        name   = "webapp"
        image  = "nginx:latest"
        cpu    = 0.5
        memory = "1Gi"
      }
    ]
  }

  ingress = {
    target_port      = 80
    external_enabled = true
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }
}
```

### API with Health Probes

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "api"
  environment = "prod"

  revision_mode = "Multiple"

  template = {
    min_replicas = 2
    max_replicas = 10

    containers = [
      {
        name   = "api"
        image  = "myregistry.azurecr.io/api:v1.0"
        cpu    = 1.0
        memory = "2Gi"
        env = [
          {
            name  = "APP_ENV"
            value = "production"
          },
          {
            name        = "DB_CONNECTION"
            secret_name = "db-connection"
          }
        ]
        liveness_probe = {
          transport      = "HTTP"
          port           = 8080
          path           = "/health/live"
          initial_delay  = 5
          interval_seconds = 30
        }
        readiness_probe = {
          transport      = "HTTP"
          port           = 8080
          path           = "/health/ready"
          initial_delay  = 0
          interval_seconds = 10
        }
      }
    ]

    http_scale_rule = [
      {
        name                = "http-scaling"
        concurrent_requests = 100
      }
    ]
  }

  ingress = {
    target_port      = 8080
    external_enabled = true
    transport        = "http"
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }

  secrets = [
    {
      name                = "db-connection"
      key_vault_secret_id = azurerm_key_vault_secret.db_connection.id
      identity            = "system"
    }
  ]

  identity = {
    type = "SystemAssigned"
  }
}
```

### With Private Registry

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "worker"
  environment = "prod"

  template = {
    min_replicas = 1
    max_replicas = 20

    containers = [
      {
        name   = "worker"
        image  = "myregistry.azurecr.io/worker:v1.0"
        cpu    = 2.0
        memory = "4Gi"
      }
    ]

    azure_queue_scale_rule = [
      {
        name         = "queue-scaling"
        queue_name   = "work-items"
        queue_length = 10
        authentication = [
          {
            secret_name       = "queue-connection"
            trigger_parameter = "connection"
          }
        ]
      }
    ]
  }

  registries = [
    {
      server   = "myregistry.azurecr.io"
      identity = azurerm_user_assigned_identity.acr_pull.id
    }
  ]

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.acr_pull.id]
  }
}
```

### With Dapr

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "dapr-app"
  environment = "dev"

  template = {
    min_replicas = 1
    max_replicas = 5

    containers = [
      {
        name   = "app"
        image  = "myapp:latest"
        cpu    = 0.5
        memory = "1Gi"
      }
    ]
  }

  dapr = {
    app_id       = "myapp"
    app_port     = 3000
    app_protocol = "http"
  }

  ingress = {
    target_port      = 3000
    external_enabled = true
  }
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
| container_app_environment_id | Environment ID | `string` | n/a | yes |
| template | Template configuration | `object` | n/a | yes |
| name | Container App name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| revision_mode | Single or Multiple | `string` | `"Single"` | no |
| ingress | Ingress configuration | `object` | `null` | no |
| dapr | Dapr configuration | `object` | `null` | no |
| secrets | Secrets list | `list(object)` | `[]` | no |
| registries | Registry credentials | `list(object)` | `[]` | no |
| identity | Managed identity config | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Container App ID |
| name | Container App name |
| latest_revision_name | Latest revision name |
| latest_revision_fqdn | Latest revision FQDN |
| outbound_ip_addresses | Outbound IP addresses |
| custom_domain_verification_id | Domain verification ID |
| identity | Identity configuration |
| principal_id | System assigned identity principal ID |

## Notes

- Container Apps require a Container App Environment
- Use Multiple revision mode for blue-green or canary deployments
- Scale rules can be combined for complex scaling scenarios
- Use managed identity for ACR authentication instead of username/password

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
| [azurerm_container_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | The ID of the Container App Environment where the Container App will be deployed. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_dapr"></a> [dapr](#input\_dapr) | Dapr configuration for the Container App. | <pre>object({<br/>    app_id       = string<br/>    app_port     = optional(number)<br/>    app_protocol = optional(string, "http")<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the Container App. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Ingress configuration for the Container App. | <pre>object({<br/>    allow_insecure_connections = optional(bool, false)<br/>    external_enabled           = optional(bool, true)<br/>    target_port                = number<br/>    exposed_port               = optional(number)<br/>    transport                  = optional(string, "auto")<br/>    traffic_weight = optional(list(object({<br/>      label           = optional(string)<br/>      latest_revision = optional(bool, true)<br/>      revision_suffix = optional(string)<br/>      percentage      = number<br/>    })), [])<br/>    ip_security_restriction = optional(list(object({<br/>      name             = string<br/>      action           = string<br/>      ip_address_range = string<br/>      description      = optional(string)<br/>    })), [])<br/>    cors_policy = optional(object({<br/>      allowed_origins     = list(string)<br/>      allowed_methods     = optional(list(string))<br/>      allowed_headers     = optional(list(string))<br/>      expose_headers      = optional(list(string))<br/>      max_age             = optional(number)<br/>      allow_credentials   = optional(bool, false)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container App. If not provided, will be generated from naming variables. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Container App name. | `string` | `"ca"` | no |
| <a name="input_registries"></a> [registries](#input\_registries) | Container registries for pulling images. | <pre>list(object({<br/>    server               = string<br/>    username             = optional(string)<br/>    password_secret_name = optional(string)<br/>    identity             = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Container App will be created. | `string` | n/a | yes |
| <a name="input_revision_mode"></a> [revision\_mode](#input\_revision\_mode) | The revision mode of the Container App. Possible values are Single and Multiple. | `string` | `"Single"` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | List of secrets for the Container App. | <pre>list(object({<br/>    name                = string<br/>    value               = optional(string)<br/>    identity            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | The template configuration for the Container App. | <pre>object({<br/>    min_replicas    = optional(number, 0)<br/>    max_replicas    = optional(number, 10)<br/>    revision_suffix = optional(string)<br/><br/>    containers = list(object({<br/>      name    = string<br/>      image   = string<br/>      cpu     = number<br/>      memory  = string<br/>      args    = optional(list(string), [])<br/>      command = optional(list(string), [])<br/>      env = optional(list(object({<br/>        name        = string<br/>        value       = optional(string)<br/>        secret_name = optional(string)<br/>      })), [])<br/>      liveness_probe = optional(object({<br/>        transport               = string<br/>        port                    = number<br/>        path                    = optional(string)<br/>        host                    = optional(string)<br/>        initial_delay           = optional(number, 1)<br/>        interval_seconds        = optional(number, 10)<br/>        timeout                 = optional(number, 1)<br/>        failure_count_threshold = optional(number, 3)<br/>        header = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })), [])<br/>      }))<br/>      readiness_probe = optional(object({<br/>        transport               = string<br/>        port                    = number<br/>        path                    = optional(string)<br/>        host                    = optional(string)<br/>        initial_delay           = optional(number, 0)<br/>        interval_seconds        = optional(number, 10)<br/>        timeout                 = optional(number, 1)<br/>        failure_count_threshold = optional(number, 3)<br/>        success_count_threshold = optional(number, 3)<br/>        header = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })), [])<br/>      }))<br/>      startup_probe = optional(object({<br/>        transport               = string<br/>        port                    = number<br/>        path                    = optional(string)<br/>        host                    = optional(string)<br/>        initial_delay           = optional(number, 0)<br/>        interval_seconds        = optional(number, 10)<br/>        timeout                 = optional(number, 1)<br/>        failure_count_threshold = optional(number, 3)<br/>        header = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })), [])<br/>      }))<br/>      volume_mounts = optional(list(object({<br/>        name = string<br/>        path = string<br/>      })), [])<br/>    }))<br/><br/>    init_containers = optional(list(object({<br/>      name    = string<br/>      image   = string<br/>      cpu     = optional(number, 0.25)<br/>      memory  = optional(string, "0.5Gi")<br/>      args    = optional(list(string), [])<br/>      command = optional(list(string), [])<br/>      env = optional(list(object({<br/>        name        = string<br/>        value       = optional(string)<br/>        secret_name = optional(string)<br/>      })), [])<br/>      volume_mounts = optional(list(object({<br/>        name = string<br/>        path = string<br/>      })), [])<br/>    })), [])<br/><br/>    volumes = optional(list(object({<br/>      name         = string<br/>      storage_type = optional(string, "EmptyDir")<br/>      storage_name = optional(string)<br/>    })), [])<br/><br/>    azure_queue_scale_rule = optional(list(object({<br/>      name         = string<br/>      queue_name   = string<br/>      queue_length = number<br/>      authentication = list(object({<br/>        secret_name       = string<br/>        trigger_parameter = string<br/>      }))<br/>    })), [])<br/><br/>    custom_scale_rule = optional(list(object({<br/>      name             = string<br/>      custom_rule_type = string<br/>      metadata         = map(string)<br/>      authentication = optional(list(object({<br/>        secret_name       = string<br/>        trigger_parameter = string<br/>      })), [])<br/>    })), [])<br/><br/>    http_scale_rule = optional(list(object({<br/>      name                = string<br/>      concurrent_requests = number<br/>      authentication = optional(list(object({<br/>        secret_name       = string<br/>        trigger_parameter = string<br/>      })), [])<br/>    })), [])<br/><br/>    tcp_scale_rule = optional(list(object({<br/>      name                = string<br/>      concurrent_requests = number<br/>      authentication = optional(list(object({<br/>        secret_name       = string<br/>        trigger_parameter = string<br/>      })), [])<br/>    })), [])<br/>  })</pre> | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_workload_profile_name"></a> [workload\_profile\_name](#input\_workload\_profile\_name) | The workload profile name to use for the Container App. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_custom_domain_verification_id"></a> [custom\_domain\_verification\_id](#output\_custom\_domain\_verification\_id) | The verification ID for custom domains. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container App. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the Container App. |
| <a name="output_latest_revision_fqdn"></a> [latest\_revision\_fqdn](#output\_latest\_revision\_fqdn) | The FQDN of the latest revision. |
| <a name="output_latest_revision_name"></a> [latest\_revision\_name](#output\_latest\_revision\_name) | The name of the latest revision. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Container App. |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | List of outbound IP addresses. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system assigned identity (if enabled). |
<!-- END_TF_DOCS -->