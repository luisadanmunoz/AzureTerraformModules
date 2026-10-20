#############################################################################
# AZURE NETAPP FILES
#############################################################################
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "netapp_pool" {
  type = string
}
variable "service_level" {
  type = string
}
variable "size_in_tb" {
  type = string
}
/*
variable "netapp_volume" {
  type = string
}
variable "zone" {
  type = string
}
variable "volume_path" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "network_features" {
  type = string
}
variable "protocols" {
  type = list(string)
}
variable "security_style" {
  type = string
}
variable "storage_quota_in_gb" {
  type = string
}
variable "snapshot_directory_visible" {
  type = string
}
variable "name_quota_rule" {
  type = string
}
variable "quota_target" {
  type = string
}
variable "quota_size_in_kib" {
  type = string
}
variable "quota_type" {
  type = string
}
variable "snapshot_policy" {
  type = string
}

*/
variable "commom_tags" {
  default = {}
}