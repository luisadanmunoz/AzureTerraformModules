#############################################################################
# DATA COLLECTION RULE VARIABLES
#############################################################################
variable "dcr_name" {
  description = "value of the dcr name tag"
  type        = string
}

variable "resource_group_name" {
  description = "value of the resource group name tag"
  type        = string
}

variable "location" {
  description = "value of the location tag"
  type        = string
}

variable "workspace_resource_id" {
  description = "value of the workspace resource id tag"
  type        = string
}

variable "workspace_resource_name" {
  description = "value of the workspace resource name tag"
  type        = string
}

variable "dcr_vminsight_name" {
  description = "value of the dcr vminsight name tag"
  type        = string
}

variable "tags" {
  description = "value of the tags tag"
  type        = map(any)
}