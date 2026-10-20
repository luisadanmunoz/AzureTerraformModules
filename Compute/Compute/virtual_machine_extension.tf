#############################################################################
# VIRTUAL MACHINE EXTENSIONS
#############################################################################
module "virtual_machine_extension" {
  source = "./modules/virtual_machine_extension"

  for_each = var.virtual_machine_extensions

  virtual_machine_extension_name = each.value["virtual_machine_extension_name"]
  publisher                      = each.value["publisher"]
  type                           = each.value["type"]
  type_handler_version           = each.value["type_handler_version"]
  virtual_machine_id = try(
    element([for _, linux_virtual_machine in module.linux_virtual_machine : linux_virtual_machine.id if linux_virtual_machine.name == each.value["virtual_machine_name"]], 0),
    element([for _, windows_virtual_machine in module.windows_virtual_machine : windows_virtual_machine.id if windows_virtual_machine.name == each.value["virtual_machine_name"]], 0),
    each.value["virtual_machine_id"]
  )
  auto_upgrade_minor_version        = try(each.value["auto_upgrade_minor_version"], null)
  automatic_upgrade_enabled         = try(each.value["automatic_upgrade_enabled"], null)
  failure_suppression_enabled       = try(each.value["failure_suppression_enabled"], null)
  provision_after_extensions        = try(each.value["provision_after_extensions"], null)
  settings                          = try(each.value["settings"], null)
  protected_settings                = try(each.value["protected_settings"], null)
  protected_settings_from_key_vault = try(each.value["protected_settings_from_key_vault"], null)
  timeouts                          = try(each.value["timeouts"], null)
  tags                              = try(each.value["tags"], var.tags)
}
