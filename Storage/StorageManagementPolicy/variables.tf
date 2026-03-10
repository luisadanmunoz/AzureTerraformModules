################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the storage management policy."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to resources that support tagging."
  type        = map(string)
  default     = {}
}

################################################################################
# Storage Management Policy
################################################################################

variable "storage_account_id" {
  description = <<-EOT
    (Required) The ID of the Storage Account where the management policy will be applied.
    DEPENDENCY: Storage Account must exist.
  EOT
  type        = string
}

variable "rules" {
  description = <<-EOT
    (Optional) List of lifecycle management rules. Each rule defines filters and actions
    for managing blob data lifecycle (tiering, deletion, snapshots, versions).
    - name: (Required) The name of the rule. Must be unique within the policy.
    - enabled: (Optional) Whether the rule is enabled. Defaults to true.
    - filters: (Required) Filters to limit the rule to a subset of blobs.
      - blob_types: (Required) List of blob types to apply the rule to (e.g., ["blockBlob", "appendBlob"]).
      - prefix_match: (Optional) List of blob name prefixes to match.
      - match_blob_index_tag: (Optional) List of blob index tag filters.
        - name: (Required) The tag name.
        - operation: (Optional) The comparison operator. Defaults to "==".
        - value: (Required) The tag value.
    - actions: (Required) Actions to apply to filtered blobs.
      - base_blob: (Optional) Actions for base blobs.
        - tier_to_cool_after_days: (Optional) Move to cool storage after N days since modification.
        - tier_to_archive_after_days: (Optional) Move to archive storage after N days since modification.
        - delete_after_days: (Optional) Delete blob after N days since modification.
        - auto_tier_to_hot_from_cool_enabled: (Optional) Auto-tier blobs from cool back to hot on access.
      - snapshot: (Optional) Actions for blob snapshots.
        - change_tier_to_cool_after_days: (Optional) Move snapshot to cool after N days since creation.
        - change_tier_to_archive_after_days: (Optional) Move snapshot to archive after N days since creation.
        - delete_after_days: (Optional) Delete snapshot after N days since creation.
      - version: (Optional) Actions for blob versions.
        - change_tier_to_cool_after_days: (Optional) Move version to cool after N days since creation.
        - change_tier_to_archive_after_days: (Optional) Move version to archive after N days since creation.
        - delete_after_days: (Optional) Delete version after N days since creation.
  EOT
  type = list(object({
    name    = string
    enabled = optional(bool, true)
    filters = object({
      blob_types   = list(string)
      prefix_match = optional(list(string), [])
      match_blob_index_tag = optional(list(object({
        name      = string
        operation = optional(string, "==")
        value     = string
      })), [])
    })
    actions = object({
      base_blob = optional(object({
        tier_to_cool_after_days              = optional(number, null)
        tier_to_archive_after_days           = optional(number, null)
        delete_after_days                    = optional(number, null)
        auto_tier_to_hot_from_cool_enabled   = optional(bool, null)
      }), null)
      snapshot = optional(object({
        change_tier_to_cool_after_days    = optional(number, null)
        change_tier_to_archive_after_days = optional(number, null)
        delete_after_days                 = optional(number, null)
      }), null)
      version = optional(object({
        change_tier_to_cool_after_days    = optional(number, null)
        change_tier_to_archive_after_days = optional(number, null)
        delete_after_days                 = optional(number, null)
      }), null)
    })
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.rules :
      length(rule.name) > 0
    ])
    error_message = "Each rule must have a non-empty 'name'."
  }

  validation {
    condition = alltrue([
      for rule in var.rules :
      length(rule.filters.blob_types) > 0
    ])
    error_message = "Each rule must specify at least one blob_type in filters."
  }

  validation {
    condition = length(var.rules) == length(distinct([for rule in var.rules : rule.name]))
    error_message = "Rule names must be unique within the policy."
  }
}
