#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# IOT HUBS
#############################################################################
variable "iothubs" {
  description = "value to set the iot hubs"
  type = map(object({
    iothub_name                   = string
    resource_group_name           = optional(string)
    location                      = string
    event_hub_partition_count     = optional(number)
    event_hub_retention_in_days   = optional(number)
    local_authentication_enabled  = optional(bool)
    min_tls_version               = optional(string)
    public_network_access_enabled = optional(bool)
    cloud_to_device = optional(object({
      default_ttl        = optional(string)
      max_delivery_count = optional(number)
      feedback = optional(object({
        lock_duration      = optional(string)
        max_delivery_count = optional(number)
        time_to_live       = optional(string)
      }))
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    network_rule_set = optional(object({
      apply_to_builtin_eventhub_endpoint = optional(bool)
      default_action                     = optional(string)
      ip_rule = optional(list(object({
        name    = string
        ip_mask = string
        action  = optional(string)
      })))
    }))
    sku = object({
      name     = string
      capacity = number
    })
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# IOT HUB SHARED ACCESS POLICIES
#############################################################################
variable "iothub_shared_access_policies" {
  description = "value to set the iot hub shared access policies"
  type = map(object({
    iothub_shared_access_policy_name = string
    resource_group_name              = optional(string)
    iothub_name                      = optional(string)
    registry_read                    = optional(bool)
    registry_write                   = optional(bool)
    service_connect                  = optional(bool)
    device_connect                   = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB CERTIFICATES
#############################################################################
variable "iothub_certificates" {
  description = "value to set the iot hub certificates"
  type = map(object({
    iothub_certificate_name = string
    resource_group_name     = optional(string)
    iothub_name             = optional(string)
    certificate_content     = string
    is_verified             = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB CONSUMER GROUPS
#############################################################################
variable "iothub_consumer_groups" {
  description = "value to set the iot hub consumer groups"
  type = map(object({
    iothub_consumer_group_name = string
    resource_group_name        = optional(string)
    iothub_name                = optional(string)
    eventhub_endpoint_name     = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB DEVICE UPDATE ACCOUNTS
#############################################################################
variable "iothub_device_update_accounts" {
  description = "value to set the iot hub device update accounts"
  type = map(object({
    iothub_device_update_account_name = string
    resource_group_name               = optional(string)
    location                          = string
    public_network_access_enabled     = optional(bool)
    sku                               = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# IOT HUB DEVICE UPDATE INSTANCES
#############################################################################
variable "iothub_device_update_instances" {
  description = "value to set the iot hub device update instances"
  type = map(object({
    iothub_device_update_instance_name = string
    iothub_device_update_account_name  = optional(string)
    device_update_account_id           = optional(string)
    iothub_name                        = optional(string)
    iothub_id                          = optional(string)
    diagnostic_enabled                 = optional(bool)
    diagnostic_storage_account = optional(object({
      connection_string = string
      id                = string
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# IOT HUB DPS
#############################################################################
variable "iothub_dpss" {
  description = "value to set the iot hub dps resources"
  type = map(object({
    iothub_dps_name               = string
    resource_group_name           = optional(string)
    location                      = string
    allocation_policy             = optional(string)
    data_residency_enabled        = optional(bool)
    public_network_access_enabled = optional(bool)
    ip_filter_rule = optional(list(object({
      name    = string
      ip_mask = string
      action  = string
      target  = optional(string)
    })))
    linked_hub = optional(list(object({
      connection_string       = string
      location                = string
      allocation_weight       = optional(number)
      apply_allocation_policy = optional(bool)
    })))
    sku = object({
      name     = string
      capacity = number
    })
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# IOT HUB DPS CERTIFICATES
#############################################################################
variable "iothub_dps_certificates" {
  description = "value to set the iot hub dps certificates"
  type = map(object({
    iothub_dps_certificate_name = string
    resource_group_name         = optional(string)
    iothub_dps_name             = optional(string)
    certificate_content         = string
    is_verified                 = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB DPS SHARED ACCESS POLICIES
#############################################################################
variable "iothub_dps_shared_access_policies" {
  description = "value to set the iot hub dps shared access policies"
  type = map(object({
    iothub_dps_shared_access_policy_name = string
    resource_group_name                  = optional(string)
    iothub_dps_name                      = optional(string)
    enrollment_read                      = optional(bool)
    enrollment_write                     = optional(bool)
    registration_read                    = optional(bool)
    registration_write                   = optional(bool)
    service_config                       = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ENDPOINT STORAGE CONTAINERS
#############################################################################
variable "iothub_endpoint_storage_containers" {
  description = "value to set the iot hub endpoint storage containers"
  type = map(object({
    iothub_endpoint_storage_container_name = string
    resource_group_name                    = optional(string)
    iothub_name                            = optional(string)
    iothub_id                              = optional(string)
    container_name                         = string
    authentication_type                    = optional(string)
    connection_string                      = optional(string)
    endpoint_uri                           = optional(string)
    identity_id                            = optional(string)
    batch_frequency_in_seconds             = optional(number)
    encoding                               = optional(string)
    file_name_format                       = optional(string)
    max_chunk_size_in_bytes                = optional(number)
    subscription_id                        = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ENDPOINT EVENTHUBS
#############################################################################
variable "iothub_endpoint_eventhubs" {
  description = "value to set the iot hub endpoint eventhubs"
  type = map(object({
    iothub_endpoint_eventhub_name = string
    resource_group_name           = optional(string)
    iothub_name                   = optional(string)
    iothub_id                     = optional(string)
    authentication_type           = optional(string)
    connection_string             = optional(string)
    endpoint_uri                  = optional(string)
    entity_path                   = optional(string)
    identity_id                   = optional(string)
    subscription_id               = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ENDPOINT SERVICEBUS QUEUES
#############################################################################
variable "iothub_endpoint_servicebus_queues" {
  description = "value to set the iot hub endpoint servicebus queues"
  type = map(object({
    iothub_endpoint_servicebus_queue_name = string
    resource_group_name                   = optional(string)
    iothub_name                           = optional(string)
    iothub_id                             = optional(string)
    authentication_type                   = optional(string)
    connection_string                     = optional(string)
    endpoint_uri                          = optional(string)
    entity_path                           = optional(string)
    identity_id                           = optional(string)
    subscription_id                       = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ENDPOINT SERVICEBUS TOPICS
#############################################################################
variable "iothub_endpoint_servicebus_topics" {
  description = "value to set the iot hub endpoint servicebus topics"
  type = map(object({
    iothub_endpoint_servicebus_topic_name = string
    resource_group_name                   = optional(string)
    iothub_name                           = optional(string)
    iothub_id                             = optional(string)
    authentication_type                   = optional(string)
    connection_string                     = optional(string)
    endpoint_uri                          = optional(string)
    entity_path                           = optional(string)
    identity_id                           = optional(string)
    subscription_id                       = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ENDPOINT COSMOSDB ACCOUNTS
#############################################################################
variable "iothub_endpoint_cosmosdb_accounts" {
  description = "value to set the iot hub endpoint cosmosdb accounts"
  type = map(object({
    iothub_endpoint_cosmosdb_account_name = string
    resource_group_name                   = optional(string)
    iothub_name                           = optional(string)
    iothub_id                             = optional(string)
    container_name                        = string
    database_name                         = string
    endpoint_uri                          = string
    authentication_type                   = optional(string)
    identity_id                           = optional(string)
    partition_key_name                    = optional(string)
    partition_key_template                = optional(string)
    primary_key                           = optional(string)
    secondary_key                         = optional(string)
    subscription_id                       = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ROUTES
#############################################################################
variable "iothub_routes" {
  description = "value to set the iot hub routes"
  type = map(object({
    iothub_route_name   = string
    resource_group_name = optional(string)
    iothub_name         = optional(string)
    source              = string
    endpoint_names      = list(string)
    enabled             = bool
    condition           = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB ENRICHMENTS
#############################################################################
variable "iothub_enrichments" {
  description = "value to set the iot hub enrichments"
  type = map(object({
    resource_group_name = optional(string)
    iothub_name         = optional(string)
    key                 = string
    value               = string
    endpoint_names      = list(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB FALLBACK ROUTES
#############################################################################
variable "iothub_fallback_routes" {
  description = "value to set the iot hub fallback routes"
  type = map(object({
    resource_group_name = optional(string)
    iothub_name         = optional(string)
    enabled             = bool
    endpoint_names      = list(string)
    source              = optional(string)
    condition           = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# IOT HUB FILE UPLOADS
#############################################################################
variable "iothub_file_uploads" {
  description = "value to set the iot hub file uploads"
  type = map(object({
    iothub_name           = optional(string)
    iothub_id             = optional(string)
    connection_string     = string
    container_name        = string
    authentication_type   = optional(string)
    identity_id           = optional(string)
    default_ttl           = optional(string)
    lock_duration         = optional(string)
    max_delivery_count    = optional(number)
    notifications_enabled = optional(bool)
    sas_ttl               = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# DIGITAL TWINS INSTANCES
#############################################################################
variable "digital_twins_instances" {
  description = "value to set the digital twins instances"
  type = map(object({
    digital_twins_instance_name = string
    resource_group_name         = optional(string)
    location                    = string
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# DIGITAL TWINS ENDPOINT EVENTGRIDS
#############################################################################
variable "digital_twins_endpoint_eventgrids" {
  description = "value to set the digital twins endpoint eventgrids"
  type = map(object({
    digital_twins_endpoint_eventgrid_name = string
    digital_twins_instance_name           = optional(string)
    digital_twins_id                      = optional(string)
    eventgrid_topic_endpoint              = string
    eventgrid_topic_primary_access_key    = string
    eventgrid_topic_secondary_access_key  = string
    dead_letter_storage_secret            = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# DIGITAL TWINS ENDPOINT EVENTHUBS
#############################################################################
variable "digital_twins_endpoint_eventhubs" {
  description = "value to set the digital twins endpoint eventhubs"
  type = map(object({
    digital_twins_endpoint_eventhub_name = string
    digital_twins_instance_name          = optional(string)
    digital_twins_id                     = optional(string)
    eventhub_primary_connection_string   = string
    eventhub_secondary_connection_string = string
    dead_letter_storage_secret           = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# DIGITAL TWINS ENDPOINT SERVICEBUSES
#############################################################################
variable "digital_twins_endpoint_servicebuses" {
  description = "value to set the digital twins endpoint servicebuses"
  type = map(object({
    digital_twins_endpoint_servicebus_name = string
    digital_twins_instance_name            = optional(string)
    digital_twins_id                       = optional(string)
    servicebus_primary_connection_string   = string
    servicebus_secondary_connection_string = string
    dead_letter_storage_secret             = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# DIGITAL TWINS TIME SERIES DATABASE CONNECTIONS
#############################################################################
variable "digital_twins_time_series_database_connections" {
  description = "value to set the digital twins time series database connections"
  type = map(object({
    digital_twins_time_series_database_connection_name = string
    digital_twins_instance_name                        = optional(string)
    digital_twins_id                                   = optional(string)
    eventhub_name                                      = string
    eventhub_namespace_endpoint_uri                    = string
    eventhub_namespace_id                              = string
    eventhub_consumer_group_name                       = optional(string)
    kusto_cluster_id                                   = string
    kusto_cluster_uri                                  = string
    kusto_database_name                                = string
    kusto_table_name                                   = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
