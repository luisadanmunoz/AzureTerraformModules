################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Database Migration Project."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "service_name" {
  description = "The name of the Database Migration Service."
  type        = string
}

variable "source_platform" {
  description = "The source platform. Possible values: SQL, MySQL, PostgreSql, MongoDb, Unknown."
  type        = string
}

variable "target_platform" {
  description = "The target platform. Possible values: SQLDB, AzureDbForMySql, AzureDbForPostgreSql, MongoDb, Unknown."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Database Migration Project."
  type        = bool
  default     = true
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
