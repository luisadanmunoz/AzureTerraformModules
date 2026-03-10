################################################################################
# Microsoft Intune Mobile App - iOS Store App
################################################################################

resource "microsoft365_mobile_app_ios_store" "this" {
  count = var.create && var.app_type == "iosStoreApp" ? 1 : 0

  display_name            = var.display_name
  description             = var.description
  publisher               = var.publisher
  is_featured             = var.is_featured
  privacy_information_url = var.privacy_information_url
  information_url         = var.information_url
  owner                   = var.owner
  developer               = var.developer
  notes                   = var.notes

  app_store_url = var.ios_store_app.app_store_url
  bundle_id     = var.ios_store_app.bundle_id

  dynamic "applicable_device_type" {
    for_each = var.ios_store_app.applicable_device_type != null ? [var.ios_store_app.applicable_device_type] : []
    content {
      ipad            = applicable_device_type.value.ipad
      iphone_and_ipod = applicable_device_type.value.iphone_and_ipod
    }
  }

  dynamic "minimum_supported_operating_system" {
    for_each = var.ios_store_app.minimum_supported_operating_system != null ? [var.ios_store_app.minimum_supported_operating_system] : []
    content {
      v11_0 = minimum_supported_operating_system.value.v11_0
      v12_0 = minimum_supported_operating_system.value.v12_0
      v13_0 = minimum_supported_operating_system.value.v13_0
      v14_0 = minimum_supported_operating_system.value.v14_0
      v15_0 = minimum_supported_operating_system.value.v15_0
      v16_0 = minimum_supported_operating_system.value.v16_0
    }
  }

  dynamic "assignment" {
    for_each = var.assignments
    content {
      intent      = assignment.value.intent
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}

################################################################################
# Microsoft Intune Mobile App - Android Store App
################################################################################

resource "microsoft365_mobile_app_android_store" "this" {
  count = var.create && var.app_type == "androidStoreApp" ? 1 : 0

  display_name            = var.display_name
  description             = var.description
  publisher               = var.publisher
  is_featured             = var.is_featured
  privacy_information_url = var.privacy_information_url
  information_url         = var.information_url
  owner                   = var.owner
  developer               = var.developer
  notes                   = var.notes

  app_store_url = var.android_store_app.app_store_url
  package_id    = var.android_store_app.package_id

  dynamic "minimum_supported_operating_system" {
    for_each = var.android_store_app.minimum_supported_operating_system != null ? [var.android_store_app.minimum_supported_operating_system] : []
    content {
      v5_0  = minimum_supported_operating_system.value.v5_0
      v5_1  = minimum_supported_operating_system.value.v5_1
      v6_0  = minimum_supported_operating_system.value.v6_0
      v7_0  = minimum_supported_operating_system.value.v7_0
      v7_1  = minimum_supported_operating_system.value.v7_1
      v8_0  = minimum_supported_operating_system.value.v8_0
      v8_1  = minimum_supported_operating_system.value.v8_1
      v9_0  = minimum_supported_operating_system.value.v9_0
      v10_0 = minimum_supported_operating_system.value.v10_0
      v11_0 = minimum_supported_operating_system.value.v11_0
    }
  }

  dynamic "assignment" {
    for_each = var.assignments
    content {
      intent      = assignment.value.intent
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}

################################################################################
# Microsoft Intune Mobile App - Web Link
################################################################################

resource "microsoft365_mobile_app_web_link" "this" {
  count = var.create && var.app_type == "webLink" ? 1 : 0

  display_name            = var.display_name
  description             = var.description
  publisher               = var.publisher
  is_featured             = var.is_featured
  privacy_information_url = var.privacy_information_url
  information_url         = var.information_url
  owner                   = var.owner
  developer               = var.developer
  notes                   = var.notes

  app_url             = var.web_link_app.app_url
  use_managed_browser = var.web_link_app.use_managed_browser

  dynamic "assignment" {
    for_each = var.assignments
    content {
      intent      = assignment.value.intent
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}

################################################################################
# Microsoft Intune Mobile App - Win32 LOB App
################################################################################

resource "microsoft365_mobile_app_win32_lob" "this" {
  count = var.create && var.app_type == "win32LobApp" ? 1 : 0

  display_name            = var.display_name
  description             = var.description
  publisher               = var.publisher
  is_featured             = var.is_featured
  privacy_information_url = var.privacy_information_url
  information_url         = var.information_url
  owner                   = var.owner
  developer               = var.developer
  notes                   = var.notes

  file_name                = var.win32_lob_app.file_name
  install_command_line     = var.win32_lob_app.install_command_line
  uninstall_command_line   = var.win32_lob_app.uninstall_command_line
  install_experience_type  = var.win32_lob_app.install_experience_type
  device_restart_behavior  = var.win32_lob_app.device_restart_behavior

  dynamic "return_codes" {
    for_each = var.win32_lob_app.return_codes
    content {
      return_code = return_codes.value.return_code
      type        = return_codes.value.type
    }
  }

  dynamic "detection_rules" {
    for_each = var.win32_lob_app.detection_rules
    content {
      type                      = detection_rules.value.type
      path                      = detection_rules.value.path
      file_or_folder_name       = detection_rules.value.file_or_folder_name
      detection_type            = detection_rules.value.detection_type
      check_32_bit_on_64_system = detection_rules.value.check_32_bit_on_64_system
      operator                  = detection_rules.value.operator
      detection_value           = detection_rules.value.detection_value
      registry_key_path         = detection_rules.value.registry_key_path
      registry_value_name       = detection_rules.value.registry_value_name
      script_content            = detection_rules.value.script_content
      enforce_signature_check   = detection_rules.value.enforce_signature_check
      run_as_32_bit             = detection_rules.value.run_as_32_bit
    }
  }

  dynamic "requirement_rules" {
    for_each = var.win32_lob_app.requirement_rules
    content {
      type                         = requirement_rules.value.type
      operator                     = requirement_rules.value.operator
      detection_value              = requirement_rules.value.detection_value
      minimum_supported_os_version = requirement_rules.value.minimum_supported_os_version
      maximum_supported_os_version = requirement_rules.value.maximum_supported_os_version
    }
  }

  dynamic "assignment" {
    for_each = var.assignments
    content {
      intent      = assignment.value.intent
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}
