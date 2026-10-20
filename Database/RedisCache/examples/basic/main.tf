################################################################################
# Example: Azure Cache for Redis
# Production Configuration with Premium Features
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-redis-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure (Best Practice: VNet Integration for Premium)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-redis-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "redis" {
  name                 = "snet-redis"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

################################################################################
# Backup Storage (Premium feature: RDB persistence)
################################################################################

resource "azurerm_storage_account" "backup" {
  name                     = "stredisbackup${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  # Security best practices
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

################################################################################
# Standard Cache - Session Store (Cost-Optimized)
# Best Practices:
# - TLS 1.2 enforced
# - No non-SSL port
# - Appropriate memory policy for session data
################################################################################

module "session_cache" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "sessions"
  environment = "prod"

  sku_name = "Standard"
  family   = "C"
  capacity = 2  # 2.5 GB

  # Security best practices
  minimum_tls_version = "1.2"
  enable_non_ssl_port = false

  redis_configuration = {
    maxmemory_policy = "volatile-ttl"  # Best for session data with TTL
  }

  firewall_rules = [
    {
      name     = "app-servers"
      start_ip = "10.0.0.0"
      end_ip   = "10.0.255.255"
    }
  ]

  tags = {
    Environment = "Production"
    Purpose     = "Session Store"
  }
}

################################################################################
# Premium Cache - High-Performance with Clustering
# Best Practices:
# - VNet integration for network isolation
# - Zone redundancy for high availability
# - RDB persistence for data durability
# - Clustering for scalability
# - Patch schedule during low-traffic hours
################################################################################

module "enterprise_cache" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "enterprise"
  environment = "prod"

  # Premium tier with clustering
  sku_name            = "Premium"
  family              = "P"
  capacity            = 3       # 26 GB per shard
  shard_count         = 3       # 3 shards = 78 GB total
  replicas_per_master = 1       # 1 replica per shard for HA

  # Security best practices
  minimum_tls_version = "1.2"
  enable_non_ssl_port = false

  # VNet integration (Premium feature)
  subnet_id = azurerm_subnet.redis.id

  # Zone redundancy (Premium feature)
  zones = ["1", "2", "3"]

  # Persistence configuration (Premium feature)
  redis_configuration = {
    # RDB backup for point-in-time recovery
    rdb_backup_enabled            = true
    rdb_backup_frequency          = 60  # Every hour
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = azurerm_storage_account.backup.primary_blob_connection_string

    # Memory management
    maxmemory_policy     = "allkeys-lru"
    maxmemory_reserved   = 10  # 10% reserved for non-cache operations
    maxmemory_delta      = 10

    # Authentication
    enable_authentication = true
  }

  # Maintenance window (Sunday 2:00 AM UTC)
  patch_schedules = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 2
    }
  ]

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment  = "Production"
    Purpose      = "Enterprise Cache"
    CostCenter   = "Platform"
    HighAvailability = "true"
  }
}

################################################################################
# Outputs
################################################################################

output "session_cache_hostname" {
  value = module.session_cache.hostname
}

output "session_cache_ssl_port" {
  value = module.session_cache.ssl_port
}

output "session_cache_connection_string" {
  value     = module.session_cache.primary_connection_string
  sensitive = true
}

output "enterprise_cache_hostname" {
  value = module.enterprise_cache.hostname
}

output "enterprise_cache_ssl_port" {
  value = module.enterprise_cache.ssl_port
}

output "enterprise_cache_connection_string" {
  value     = module.enterprise_cache.primary_connection_string
  sensitive = true
}

output "enterprise_cache_principal_id" {
  value = module.enterprise_cache.principal_id
}
