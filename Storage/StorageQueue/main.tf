################################################################################
# Azure Storage Queue Module
################################################################################

/**
 * # Azure Storage Queue Module
 *
 * Reusable module for creating Storage Queues in Azure.
 * Supports creating a single queue (using count) or multiple queues (using for_each).
 */

################################################################################
# Single Storage Queue (when queues map is not provided)
################################################################################

# DEPENDENCY: Storage Account must exist before creating this resource
resource "azurerm_storage_queue" "this" {
  count = var.create && !local.use_multiple_queues ? 1 : 0

  name                 = local.resource_name
  storage_account_name = var.storage_account_name # DEPENDENCY: Storage Account

  metadata = length(var.metadata) > 0 ? var.metadata : null
}

################################################################################
# Multiple Storage Queues (when queues map is provided)
################################################################################

# DEPENDENCY: Storage Account must exist before creating this resource
resource "azurerm_storage_queue" "multiple" {
  for_each = var.create ? var.queues : {}

  name                 = each.key
  storage_account_name = var.storage_account_name # DEPENDENCY: Storage Account

  metadata = length(each.value.metadata) > 0 ? each.value.metadata : null
}
