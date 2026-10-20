# Azure Event Grid Domain Terraform Module

This Terraform module creates an Azure Event Grid Domain with optional domain topics, managed identity support, and configurable network access controls.

## Features

- Create Azure Event Grid Domain with flexible naming conventions
- Support for multiple input schemas (EventGridSchema, CustomEventSchema, CloudEventSchemaV1_0)
- Managed identity support (System-assigned, User-assigned, or both)
- Network access control with inbound IP rules
- Domain topics management
- Custom event schema mapping
- Conditional resource creation with `create` flag

## Usage

### Basic Usage

```hcl
module "eventgrid_domain" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
  name                = "evgd-myapp-prod"

  tags = {
    Environment = "Production"
    Application = "MyApp"
  }
}
```

### With Domain Topics

```hcl
module "eventgrid_domain" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
  workload            = "myapp"
  environment         = "prod"
  instance            = "001"

  domain_topics = {
    orders = {
      name = "orders"
    }
    customers = {
      name = "customers"
    }
    inventory = {
      name = "inventory"
    }
  }

  tags = {
    Environment = "Production"
  }
}
```

### With Managed Identity

```hcl
module "eventgrid_domain" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
  name                = "evgd-myapp-prod"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
```

### With User-Assigned Managed Identity

```hcl
resource "azurerm_user_assigned_identity" "eventgrid" {
  name                = "id-eventgrid-prod"
  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
}

module "eventgrid_domain" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
  name                = "evgd-myapp-prod"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.eventgrid.id]
  }

  tags = {
    Environment = "Production"
  }
}
```

### With Network Restrictions

```hcl
module "eventgrid_domain" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name           = "rg-myapp-prod"
  location                      = "eastus"
  name                          = "evgd-myapp-prod"
  public_network_access_enabled = true

  inbound_ip_rule = [
    {
      ip_mask = "10.0.0.0/8"
      action  = "Allow"
    },
    {
      ip_mask = "192.168.1.0/24"
      action  = "Allow"
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

### With Custom Event Schema

```hcl
module "eventgrid_domain" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
  name                = "evgd-myapp-prod"
  input_schema        = "CustomEventSchema"

  input_mapping_fields = {
    id         = "customId"
    topic      = "customTopic"
    event_type = "customEventType"
    event_time = "customEventTime"
    subject    = "customSubject"
  }

  input_mapping_default_values = {
    event_type   = "DefaultEventType"
    data_version = "1.0"
    subject      = "DefaultSubject"
  }

  tags = {
    Environment = "Production"
  }
}
```

### Multi-Tenant Architecture Example

```hcl
# Create Event Grid Domains for multiple tenants
locals {
  tenants = {
    tenant_a = {
      name        = "evgd-tenant-a-prod"
      environment = "prod"
      topics      = ["orders", "shipments", "notifications"]
    }
    tenant_b = {
      name        = "evgd-tenant-b-prod"
      environment = "prod"
      topics      = ["orders", "inventory", "billing"]
    }
    tenant_c = {
      name        = "evgd-tenant-c-prod"
      environment = "prod"
      topics      = ["users", "events", "analytics"]
    }
  }
}

module "eventgrid_domains" {
  source   = "path/to/modules/EventGridDomain"
  for_each = local.tenants

  resource_group_name = "rg-multitenant-prod"
  location            = "eastus"
  name                = each.value.name

  identity = {
    type = "SystemAssigned"
  }

  domain_topics = {
    for topic in each.value.topics : topic => {
      name = topic
    }
  }

  tags = {
    Environment = each.value.environment
    Tenant      = each.key
  }
}

# Output all domain endpoints for multi-tenant routing
output "tenant_domain_endpoints" {
  value = {
    for tenant, domain in module.eventgrid_domains : tenant => domain.endpoint
  }
}
```

### Multi-Region Deployment Example

```hcl
locals {
  regions = {
    primary = {
      location = "eastus"
      instance = "001"
    }
    secondary = {
      location = "westus2"
      instance = "002"
    }
    dr = {
      location = "northeurope"
      instance = "003"
    }
  }
}

module "eventgrid_domain_regional" {
  source   = "path/to/modules/EventGridDomain"
  for_each = local.regions

  resource_group_name = "rg-events-${each.key}"
  location            = each.value.location
  workload            = "events"
  environment         = "prod"
  instance            = each.value.instance

  identity = {
    type = "SystemAssigned"
  }

  public_network_access_enabled = false

  domain_topics = {
    critical_events = {
      name = "critical-events"
    }
    audit_events = {
      name = "audit-events"
    }
  }

  tags = {
    Environment = "Production"
    Region      = each.key
  }
}
```

### CloudEvents Schema Example

```hcl
module "eventgrid_domain_cloudevents" {
  source = "path/to/modules/EventGridDomain"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"
  name                = "evgd-cloudevents-prod"
  input_schema        = "CloudEventSchemaV1_0"

  identity = {
    type = "SystemAssigned"
  }

  domain_topics = {
    cloud_native_events = {
      name = "cloud-native-events"
    }
  }

  tags = {
    Environment = "Production"
    Schema      = "CloudEvents"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_domain.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain) | resource |
| [azurerm_eventgrid_domain_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group in which to create the Event Grid Domain. | `string` | n/a | yes |
| location | The Azure region where the Event Grid Domain should be created. | `string` | n/a | yes |
| create | Controls whether resources should be created. | `bool` | `true` | no |
| name | The name of the Event Grid Domain. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | The prefix to use for the generated Event Grid Domain name. | `string` | `"evgd"` | no |
| workload | The workload name to use in the generated Event Grid Domain name. | `string` | `null` | no |
| environment | The environment name to use in the generated Event Grid Domain name. | `string` | `null` | no |
| instance | The instance identifier to use in the generated Event Grid Domain name. | `string` | `null` | no |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| input_schema | Specifies the schema in which incoming events will be published. | `string` | `"EventGridSchema"` | no |
| public_network_access_enabled | Whether or not public network access is allowed. | `bool` | `true` | no |
| local_auth_enabled | Whether local authentication methods (SAS keys) is enabled. | `bool` | `true` | no |
| auto_create_topic_with_first_subscription | Whether to automatically create a topic when a subscription is created. | `bool` | `true` | no |
| auto_delete_topic_with_last_subscription | Whether to automatically delete a topic when the last subscription is deleted. | `bool` | `true` | no |
| input_mapping_fields | A mapping of input fields to Event Grid schema fields. | `object` | `null` | no |
| input_mapping_default_values | Default values for input mapping fields. | `object` | `null` | no |
| inbound_ip_rule | A list of inbound IP rules to allow specific IP addresses or ranges. | `list(object)` | `[]` | no |
| identity | An identity block for managed identity configuration. | `object` | `null` | no |
| domain_topics | A map of domain topics to create within this Event Grid Domain. | `map(object)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Event Grid Domain. |
| name | The name of the Event Grid Domain. |
| endpoint | The endpoint of the Event Grid Domain. |
| primary_access_key | The primary access key for the Event Grid Domain. |
| secondary_access_key | The secondary access key for the Event Grid Domain. |
| domain_topic_ids | A map of domain topic names to their IDs. |
| principal_id | The Principal ID of the system-assigned managed identity. |

## License

This module is licensed under the MIT License.
