#############################################################################
# NETWORK SECURITY RULE VARIABLES
#############################################################################
variable "name_rule" {
  type = string
}
variable "direction" {
  type = string
}
variable "access" {
  type = string
}
variable "priority" {
  type = string
}
variable "protocol" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "network_security_group_name" {
  type = string
}
variable "source_port_range" {
  type = string
}
variable "source_port_ranges" {
  type = set(string)
}
variable "destination_port_range" {
  type = string
}
variable "destination_port_ranges" {
  type = set(string)
}
variable "source_address_prefix" {
  type = string
}
variable "source_address_prefixes" {
  type = set(string)
}
variable "destination_address_prefix" {
  type = string
}
variable "destination_address_prefixes" {
  type = set(string)
}
variable "source_application_security_group_ids" {
  type = set(string)
}
variable "destination_application_security_group_ids" {
  type = set(string)
}
