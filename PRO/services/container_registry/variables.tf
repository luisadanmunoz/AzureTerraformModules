#############################################################################
# CONTAINER REGISTRY
#############################################################################
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
#############################################################################
# CONTAINER REGISTRY - PRIVATE ENDPOINT
#############################################################################
variable "subnet_id" {
  type = string
}
variable "private_dns_zone_ids" {
  type = string
}
variable "tags" {
  default = {}
}
