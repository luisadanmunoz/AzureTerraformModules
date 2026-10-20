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
# AI SERVICES
#############################################################################
variable "ai_services" {
  description = "value to set the ai services accounts"
  type = map(object({
    ai_services_name                   = string
    resource_group_name                = optional(string)
    location                           = string
    sku_name                           = string
    custom_subdomain_name              = optional(string)
    fqdns                              = optional(list(string))
    local_authentication_enabled       = optional(bool)
    outbound_network_access_restricted = optional(bool)
    public_network_access              = optional(string)
    customer_managed_key = optional(object({
      identity_client_id = optional(string)
      key_vault_key_id   = optional(string)
      managed_hsm_key_id = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    network_acls = optional(object({
      bypass         = optional(string)
      default_action = string
      ip_rules       = optional(list(string))
      virtual_network_rules = optional(list(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })))
    }))
    storage = optional(object({
      storage_account_id = string
      identity_client_id = optional(string)
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
# AI FOUNDRY
#############################################################################
variable "ai_foundries" {
  description = "value to set the ai foundries"
  type = map(object({
    ai_foundry_name     = string
    resource_group_name = optional(string)
    location            = string
    storage_account_id  = string
    key_vault_id        = string
    identity = object({
      type         = string
      identity_ids = optional(list(string))
    })
    application_insights_id        = optional(string)
    container_registry_id          = optional(string)
    description                    = optional(string)
    friendly_name                  = optional(string)
    high_business_impact_enabled   = optional(bool)
    primary_user_assigned_identity = optional(string)
    public_network_access          = optional(string)
    encryption = optional(object({
      key_id                    = string
      key_vault_id              = string
      user_assigned_identity_id = optional(string)
    }))
    managed_network = optional(object({
      isolation_mode = optional(string)
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

variable "ai_foundry_projects" {
  description = "value to set the ai foundry projects"
  type = map(object({
    ai_foundry_project_name        = string
    location                       = string
    ai_foundry_name                = optional(string)
    ai_services_hub_id             = optional(string)
    description                    = optional(string)
    friendly_name                  = optional(string)
    high_business_impact_enabled   = optional(bool)
    primary_user_assigned_identity = optional(string)
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
# COGNITIVE ACCOUNTS
#############################################################################
variable "cognitive_accounts" {
  description = "value to set the cognitive accounts"
  type = map(object({
    cognitive_account_name                       = string
    resource_group_name                          = optional(string)
    location                                     = string
    kind                                         = string
    sku_name                                     = string
    custom_subdomain_name                        = optional(string)
    dynamic_throttling_enabled                   = optional(bool)
    fqdns                                        = optional(list(string))
    local_auth_enabled                           = optional(bool)
    metrics_advisor_aad_client_id                = optional(string)
    metrics_advisor_aad_tenant_id                = optional(string)
    metrics_advisor_super_user_name              = optional(string)
    metrics_advisor_website_name                 = optional(string)
    outbound_network_access_restricted           = optional(bool)
    project_management_enabled                   = optional(bool)
    public_network_access_enabled                = optional(bool)
    qna_runtime_endpoint                         = optional(string)
    custom_question_answering_search_service_id  = optional(string)
    custom_question_answering_search_service_key = optional(string)
    customer_managed_key = optional(object({
      key_vault_key_id   = string
      identity_client_id = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    network_acls = optional(object({
      bypass         = optional(string)
      default_action = string
      ip_rules       = optional(list(string))
      virtual_network_rules = optional(list(object({
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })))
    }))
    network_injection = optional(object({
      scenario  = string
      subnet_id = string
    }))
    storage = optional(object({
      storage_account_id = string
      identity_client_id = optional(string)
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

variable "cognitive_account_projects" {
  description = "value to set the cognitive account projects"
  type = map(object({
    cognitive_account_project_name = string
    location                       = string
    cognitive_account_name         = optional(string)
    cognitive_account_id           = optional(string)
    description                    = optional(string)
    display_name                   = optional(string)
    identity = object({
      type         = string
      identity_ids = optional(list(string))
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

variable "cognitive_account_customer_managed_keys" {
  description = "value to set the cognitive account customer managed keys"
  type = map(object({
    cognitive_account_name = optional(string)
    cognitive_account_id   = optional(string)
    key_vault_key_id       = string
    identity_client_id     = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

variable "cognitive_account_rai_policies" {
  description = "value to set the cognitive account rai policies"
  type = map(object({
    cognitive_account_rai_policy_name = string
    cognitive_account_name            = optional(string)
    cognitive_account_id              = optional(string)
    base_policy_name                  = string
    mode                              = optional(string)
    content_filter = list(object({
      name               = string
      filter_enabled     = bool
      block_enabled      = bool
      severity_threshold = string
      source             = string
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

variable "cognitive_account_rai_blocklists" {
  description = "value to set the cognitive account rai blocklists"
  type = map(object({
    cognitive_account_rai_blocklist_name = string
    cognitive_account_name               = optional(string)
    cognitive_account_id                 = optional(string)
    description                          = optional(string)
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

variable "cognitive_deployments" {
  description = "value to set the cognitive deployments"
  type = map(object({
    cognitive_deployment_name  = string
    cognitive_account_name     = optional(string)
    cognitive_account_id       = optional(string)
    dynamic_throttling_enabled = optional(bool)
    rai_policy_name            = optional(string)
    version_upgrade_option     = optional(string)
    model = object({
      format  = string
      name    = string
      version = optional(string)
    })
    sku = object({
      name     = string
      capacity = optional(number)
      family   = optional(string)
      size     = optional(string)
      tier     = optional(string)
    })
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
# MACHINE LEARNING
#############################################################################
variable "machine_learning_workspaces" {
  description = "value to set the machine learning workspaces"
  type = map(object({
    machine_learning_workspace_name = string
    resource_group_name             = optional(string)
    location                        = string
    application_insights_id         = string
    key_vault_id                    = string
    storage_account_id              = string
    identity = object({
      type         = string
      identity_ids = optional(list(string))
    })
    container_registry_id           = optional(string)
    description                     = optional(string)
    friendly_name                   = optional(string)
    high_business_impact            = optional(bool)
    image_build_compute_name        = optional(string)
    kind                            = optional(string)
    primary_user_assigned_identity  = optional(string)
    public_network_access_enabled   = optional(bool)
    service_side_encryption_enabled = optional(bool)
    sku_name                        = optional(string)
    v1_legacy_mode_enabled          = optional(bool)
    encryption = optional(object({
      key_id                    = string
      key_vault_id              = string
      user_assigned_identity_id = optional(string)
    }))
    feature_store = optional(object({
      computer_spark_runtime_version = optional(string)
      offline_connection_name        = optional(string)
      online_connection_name         = optional(string)
    }))
    managed_network = optional(object({
      isolation_mode                = optional(string)
      provision_on_creation_enabled = optional(bool)
    }))
    serverless_compute = optional(object({
      public_ip_enabled = optional(bool)
      subnet_id         = optional(string)
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

variable "machine_learning_compute_clusters" {
  description = "value to set the machine learning compute clusters"
  type = map(object({
    machine_learning_compute_cluster_name = string
    machine_learning_workspace_name       = optional(string)
    machine_learning_workspace_id         = optional(string)
    location                              = string
    vm_priority                           = string
    vm_size                               = string
    scale_settings = object({
      max_node_count                       = number
      min_node_count                       = number
      scale_down_nodes_after_idle_duration = string
    })
    description               = optional(string)
    local_auth_enabled        = optional(bool)
    node_public_ip_enabled    = optional(bool)
    ssh_public_access_enabled = optional(bool)
    subnet_resource_id        = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    ssh = optional(object({
      admin_username = string
      admin_password = optional(string)
      key_value      = optional(string)
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

variable "machine_learning_compute_instances" {
  description = "value to set the machine learning compute instances"
  type = map(object({
    machine_learning_compute_instance_name = string
    machine_learning_workspace_name        = optional(string)
    machine_learning_workspace_id          = optional(string)
    virtual_machine_size                   = string
    authorization_type                     = optional(string)
    description                            = optional(string)
    local_auth_enabled                     = optional(bool)
    node_public_ip_enabled                 = optional(bool)
    subnet_resource_id                     = optional(string)
    assign_to_user = optional(object({
      object_id = optional(string)
      tenant_id = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    ssh = optional(object({
      public_key = string
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

variable "machine_learning_inference_clusters" {
  description = "value to set the machine learning inference clusters"
  type = map(object({
    machine_learning_inference_cluster_name = string
    machine_learning_workspace_name         = optional(string)
    machine_learning_workspace_id           = optional(string)
    location                                = string
    kubernetes_cluster_id                   = string
    cluster_purpose                         = optional(string)
    description                             = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    ssl = optional(object({
      cert                      = optional(string)
      cname                     = optional(string)
      key                       = optional(string)
      leaf_domain_label         = optional(string)
      overwrite_existing_domain = optional(bool)
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

variable "machine_learning_datastore_blobstorages" {
  description = "value to set the machine learning datastore blobstorages"
  type = map(object({
    machine_learning_datastore_blobstorage_name = string
    machine_learning_workspace_name             = optional(string)
    workspace_id                                = optional(string)
    storage_container_id                        = string
    account_key                                 = optional(string)
    shared_access_signature                     = optional(string)
    description                                 = optional(string)
    is_default                                  = optional(bool)
    service_data_auth_identity                  = optional(string)
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

variable "machine_learning_datastore_datalake_gen2s" {
  description = "value to set the machine learning datastore datalake gen2s"
  type = map(object({
    machine_learning_datastore_datalake_gen2_name = string
    machine_learning_workspace_name               = optional(string)
    workspace_id                                  = optional(string)
    storage_container_id                          = string
    authority_url                                 = optional(string)
    client_id                                     = optional(string)
    client_secret                                 = optional(string)
    description                                   = optional(string)
    service_data_identity                         = optional(string)
    tenant_id                                     = optional(string)
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

variable "machine_learning_datastore_fileshares" {
  description = "value to set the machine learning datastore fileshares"
  type = map(object({
    machine_learning_datastore_fileshare_name = string
    machine_learning_workspace_name           = optional(string)
    workspace_id                              = optional(string)
    storage_fileshare_id                      = string
    account_key                               = optional(string)
    shared_access_signature                   = optional(string)
    description                               = optional(string)
    service_data_identity                     = optional(string)
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

variable "machine_learning_synapse_sparks" {
  description = "value to set the machine learning synapse sparks"
  type = map(object({
    machine_learning_synapse_spark_name = string
    machine_learning_workspace_name     = optional(string)
    machine_learning_workspace_id       = optional(string)
    location                            = string
    synapse_spark_pool_id               = string
    description                         = optional(string)
    local_auth_enabled                  = optional(bool)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

variable "machine_learning_workspace_network_outbound_rule_fqdns" {
  description = "value to set the machine learning workspace outbound rule fqdns"
  type = map(object({
    machine_learning_workspace_network_outbound_rule_fqdn_name = string
    machine_learning_workspace_name                            = optional(string)
    workspace_id                                               = optional(string)
    destination_fqdn                                           = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

variable "machine_learning_workspace_network_outbound_rule_private_endpoints" {
  description = "value to set the machine learning workspace outbound rule private endpoints"
  type = map(object({
    machine_learning_workspace_network_outbound_rule_private_endpoint_name = string
    machine_learning_workspace_name                                        = optional(string)
    workspace_id                                                           = optional(string)
    service_resource_id                                                    = string
    sub_resource_target                                                    = string
    spark_enabled                                                          = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

variable "machine_learning_workspace_network_outbound_rule_service_tags" {
  description = "value to set the machine learning workspace outbound rule service tags"
  type = map(object({
    machine_learning_workspace_network_outbound_rule_service_tag_name = string
    machine_learning_workspace_name                                   = optional(string)
    workspace_id                                                      = optional(string)
    service_tag                                                       = string
    protocol                                                          = string
    port_ranges                                                       = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
