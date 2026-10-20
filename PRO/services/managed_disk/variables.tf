#############################################################################
# MANAGED DISK VARIABLES
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
variable "storage_account_type" {
  type = string
}
variable "create_option" {
  type = string
}
variable "disk_size_gb" {
  type = string
}
variable "lun" {
  default = {}
}
variable "caching" {
  type = string
}
variable "commom_tags" {
  default = {}
}
variable "virtual_machine_id" {
  default = {}
}


