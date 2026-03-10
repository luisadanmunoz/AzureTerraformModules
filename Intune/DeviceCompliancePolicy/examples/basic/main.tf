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

provider "microsoft365" {
  # Configure authentication via environment variables:
  # - M365_TENANT_ID
  # - M365_CLIENT_ID
  # - M365_CLIENT_SECRET
}

################################################################################
# Windows 10 Compliance Policy - Basic Security
################################################################################

module "windows_compliance_basic" {
  source = "../../"

  display_name = "Windows 10 Basic Compliance"
  description  = "Basic compliance policy for Windows 10 devices"
  platform     = "windows10"

  windows_compliance_settings = {
    password_required       = true
    password_minimum_length = 8
    password_required_type  = "alphanumeric"
    secure_boot_enabled     = true
    bit_locker_enabled      = true
    defender_enabled        = true
    antivirus_required      = true
    active_firewall_required = true
  }

  scheduled_actions_for_rule = [
    {
      rule_name = "DeviceNonCompliant"
      scheduled_action_configurations = [
        {
          action_type        = "notification"
          grace_period_hours = 0
        },
        {
          action_type        = "block"
          grace_period_hours = 72
        }
      ]
    }
  ]
}

################################################################################
# Windows 10 Compliance Policy - High Security
################################################################################

module "windows_compliance_high" {
  source = "../../"

  display_name = "Windows 10 High Security Compliance"
  description  = "High security compliance policy for Windows 10 devices"
  platform     = "windows10"

  windows_compliance_settings = {
    password_required                      = true
    password_minimum_length                = 12
    password_required_type                 = "alphanumericWithSymbol"
    password_expiration_days               = 90
    password_previous_password_block_count = 5
    require_healthy_device_report          = true
    bit_locker_enabled                     = true
    secure_boot_enabled                    = true
    code_integrity_enabled                 = true
    storage_require_encryption             = true
    active_firewall_required               = true
    defender_enabled                       = true
    antivirus_required                     = true
    anti_spyware_required                  = true
    tpm_required                           = true
    os_minimum_version                     = "10.0.19041"
  }

  scheduled_actions_for_rule = [
    {
      rule_name = "DeviceNonCompliant"
      scheduled_action_configurations = [
        {
          action_type        = "block"
          grace_period_hours = 24
        }
      ]
    }
  ]
}

################################################################################
# iOS Compliance Policy
################################################################################

module "ios_compliance" {
  source = "../../"

  display_name = "iOS Corporate Compliance"
  description  = "Compliance policy for corporate iOS devices"
  platform     = "iOS"

  ios_compliance_settings = {
    passcode_required                 = true
    passcode_minimum_length           = 6
    passcode_block_simple             = true
    passcode_required_type            = "numeric"
    security_block_jailbroken_devices = true
    os_minimum_version                = "15.0"
  }
}

################################################################################
# Android Compliance Policy
################################################################################

module "android_compliance" {
  source = "../../"

  display_name = "Android Corporate Compliance"
  description  = "Compliance policy for corporate Android devices"
  platform     = "android"

  android_compliance_settings = {
    password_required                                  = true
    password_minimum_length                            = 6
    password_required_type                             = "numericComplex"
    security_block_jailbroken_devices                  = true
    security_prevent_install_apps_from_unknown_sources = true
    security_require_google_play_services              = true
    storage_require_encryption                         = true
    os_minimum_version                                 = "11"
  }
}

################################################################################
# Outputs
################################################################################

output "windows_basic_compliance_id" {
  description = "The ID of the basic Windows compliance policy."
  value       = module.windows_compliance_basic.id
}

output "windows_high_compliance_id" {
  description = "The ID of the high security Windows compliance policy."
  value       = module.windows_compliance_high.id
}

output "ios_compliance_id" {
  description = "The ID of the iOS compliance policy."
  value       = module.ios_compliance.id
}

output "android_compliance_id" {
  description = "The ID of the Android compliance policy."
  value       = module.android_compliance.id
}
