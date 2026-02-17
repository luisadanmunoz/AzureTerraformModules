################################################################################
# Provider Configuration
################################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    microsoft365 = {
      source  = "terraconfigure/microsoft365"
      version = ">= 0.1.0"
    }
  }
}

provider "microsoft365" {}

################################################################################
# Device Enrollment Limit Configuration
################################################################################

module "enrollment_limit" {
  source = "../../"

  display_name = "Corporate Device Limit"
  description  = "Maximum 5 devices per user"
  config_type  = "deviceEnrollmentLimitConfiguration"

  device_limit = 5
}

################################################################################
# Platform Restrictions Configuration
################################################################################

module "platform_restrictions" {
  source = "../../"

  display_name = "Corporate Platform Restrictions"
  description  = "Platform restrictions for corporate device enrollment"
  config_type  = "deviceEnrollmentPlatformRestrictionsConfiguration"

  platform_restrictions = {
    android_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "11.0"
    }
    android_for_work_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = false
      os_minimum_version                 = "11.0"
    }
    ios_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "15.0"
    }
    mac_os_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "12.0"
    }
    windows_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "10.0.19041"
    }
    windows_mobile_restriction = {
      platform_blocked = true
    }
  }
}

################################################################################
# Windows Hello for Business Configuration
################################################################################

module "windows_hello" {
  source = "../../"

  display_name = "Windows Hello for Business - Corporate"
  description  = "Windows Hello for Business configuration for corporate devices"
  config_type  = "deviceEnrollmentWindowsHelloForBusinessConfiguration"

  windows_hello_for_business = {
    state                          = "enabled"
    pin_minimum_length             = 6
    pin_maximum_length             = 127
    pin_uppercase_characters_usage = "required"
    pin_lowercase_characters_usage = "required"
    pin_special_characters_usage   = "allowed"
    security_device_required       = true
    unlock_with_biometrics_enabled = true
    remote_passport_enabled        = true
    pin_recovery_enabled           = true
    pin_expiration_in_days         = 90
    pin_previous_block_count       = 5
  }
}

################################################################################
# Outputs
################################################################################

output "enrollment_limit_id" {
  description = "The ID of the enrollment limit configuration."
  value       = module.enrollment_limit.id
}

output "platform_restrictions_id" {
  description = "The ID of the platform restrictions configuration."
  value       = module.platform_restrictions.id
}

output "windows_hello_id" {
  description = "The ID of the Windows Hello configuration."
  value       = module.windows_hello.id
}
