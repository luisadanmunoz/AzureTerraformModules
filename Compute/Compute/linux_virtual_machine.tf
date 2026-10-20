#############################################################################
# LINUX VIRTUAL MACHINES
#############################################################################
module "linux_virtual_machine" {
  source = "./modules/linux_virtual_machine"

  for_each = var.linux_virtual_machines

  linux_virtual_machine_name = each.value["linux_virtual_machine_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                                               = each.value["location"]
  size                                                   = each.value["size"]
  network_interface_ids                                  = each.value["network_interface_ids"]
  admin_username                                         = try(each.value["admin_username"], null)
  admin_password                                         = try(each.value["admin_password"], null)
  allow_extension_operations                             = try(each.value["allow_extension_operations"], null)
  availability_set_id                                    = try(element([for _, availability_set in module.availability_set : availability_set.id if availability_set.name == each.value["availability_set_name"]], 0), each.value["availability_set_id"], null)
  bypass_platform_safety_checks_on_user_schedule_enabled = try(each.value["bypass_platform_safety_checks_on_user_schedule_enabled"], null)
  capacity_reservation_group_id                          = try(each.value["capacity_reservation_group_id"], null)
  computer_name                                          = try(each.value["computer_name"], null)
  custom_data                                            = try(each.value["custom_data"], null)
  dedicated_host_group_id                                = try(each.value["dedicated_host_group_id"], null)
  dedicated_host_id                                      = try(each.value["dedicated_host_id"], null)
  disable_password_authentication                        = try(each.value["disable_password_authentication"], null)
  disk_controller_type                                   = try(each.value["disk_controller_type"], null)
  edge_zone                                              = try(each.value["edge_zone"], null)
  encryption_at_host_enabled                             = try(each.value["encryption_at_host_enabled"], null)
  eviction_policy                                        = try(each.value["eviction_policy"], null)
  extensions_time_budget                                 = try(each.value["extensions_time_budget"], null)
  license_type                                           = try(each.value["license_type"], null)
  max_bid_price                                          = try(each.value["max_bid_price"], null)
  patch_assessment_mode                                  = try(each.value["patch_assessment_mode"], null)
  patch_mode                                             = try(each.value["patch_mode"], null)
  platform_fault_domain                                  = try(each.value["platform_fault_domain"], null)
  priority                                               = try(each.value["priority"], null)
  provision_vm_agent                                     = try(each.value["provision_vm_agent"], null)
  proximity_placement_group_id                           = try(element([for _, proximity_placement_group in module.proximity_placement_group : proximity_placement_group.id if proximity_placement_group.name == each.value["proximity_placement_group_name"]], 0), each.value["proximity_placement_group_id"], null)
  reboot_setting                                         = try(each.value["reboot_setting"], null)
  secure_boot_enabled                                    = try(each.value["secure_boot_enabled"], null)
  source_image_id                                        = try(each.value["source_image_id"], null)
  user_data                                              = try(each.value["user_data"], null)
  virtual_machine_scale_set_id                           = try(each.value["virtual_machine_scale_set_id"], null)
  vtpm_enabled                                           = try(each.value["vtpm_enabled"], null)
  zone                                                   = try(each.value["zone"], null)
  additional_capabilities                                = try(each.value["additional_capabilities"], null)
  admin_ssh_keys = try([
    for admin_ssh_key in each.value["admin_ssh_keys"] : {
      username = admin_ssh_key.username
      public_key = try(
        element([for _, ssh_public_key in module.ssh_public_key : ssh_public_key.public_key if ssh_public_key.name == admin_ssh_key.ssh_public_key_name], 0),
        admin_ssh_key.public_key
      )
    }
  ], null)
  boot_diagnostics         = try(each.value["boot_diagnostics"], null)
  gallery_applications     = try(each.value["gallery_applications"], null)
  identity                 = try(each.value["identity"], null)
  os_disk                  = each.value["os_disk"]
  os_image_notification    = try(each.value["os_image_notification"], null)
  plan                     = try(each.value["plan"], null)
  secrets                  = try(each.value["secrets"], null)
  source_image_reference   = try(each.value["source_image_reference"], null)
  termination_notification = try(each.value["termination_notification"], null)
  timeouts                 = try(each.value["timeouts"], null)
  tags                     = try(each.value["tags"], var.tags)
}
