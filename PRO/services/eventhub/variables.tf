#############################################################################
# EVENTHUB NAMESPACE
#############################################################################
variable "namespace" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "private_dns_zone_ids" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
#############################################################################
# EVENTHUB
#############################################################################
variable "name_eventhub" {
  type = string
}
variable "subnet_id" {
  default = {}
}
#############################################################################
# EVENTHUB AUTHORIZATION RULE
#############################################################################
variable "name_authorization_rule" {
  type = string
}
