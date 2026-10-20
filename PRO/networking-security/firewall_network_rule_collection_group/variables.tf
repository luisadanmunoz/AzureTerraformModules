#############################################################################
# AZURE FIREWALL POLICY RULE COLLECTION GROUP VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "firewall_policy_id" {
  type = string
}
variable "priority" {
  type = string
}
variable "name_network_rule_collection" {
  type = string
}
variable "priority_network_rule_collection" {
  type = string
}
variable "action" {
  type = string
}
variable "name_rule" {
  type = string
}
variable "protocols" {
  type = list(string)
}
variable "source_addresses" {
  type = list(string)
}
variable "destination_addresses" {
  type = list(string)
}
variable "destination_ports" {
  type = list(string)
}