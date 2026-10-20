# #############################################################################
# PALO ALTO FIREWALL
# #############################################################################
module "palo_alto" {
  source = "./modules/palo_alto"

  for_each = var.palo_alto

  # #############################################################################
  # PALO ALTO KEYVAULT
  # #############################################################################

  keyvault_name               = each.value["keyvault_name"]
  keyvault_resourcegroup_name = each.value["keyvault_resourcegroup_name"]
  keyvault_secret_name_01     = each.value["keyvault_secret_name_01"]


  # #############################################################################
  # PALO ALTO NETWORKING
  # #############################################################################

  vnet_name_01          = each.value["vnet_name_01"]
  vnet_resourcegroup_01 = each.value["vnet_resourcegroup_01"]
  subnet_name_01        = each.value["subnet_name_01"]
  subnet_name_02        = each.value["subnet_name_02"]
  subnet_name_03        = each.value["subnet_name_03"]

  # #############################################################################
  # PALO ALTO NIC MANAGEMENT
  # #############################################################################

  interface_name_01                 = each.value["interface_name_01"]
  vm_location_01                    = each.value["vm_location_01"]
  vm_resourcegroup_01               = each.value["vm_resourcegroup_01"]
  interface_config_name_01          = each.value["interface_config_name_01"]
  interface_privateip_allocation_01 = each.value["interface_privateip_allocation_01"]
  interface_privateip_address_01    = each.value["interface_privateip_address_01"]

  # #############################################################################
  # PALO ALTO NIC TRUST
  # #############################################################################

  interface_name_02                 = each.value["interface_name_02"]
  interface_config_name_02          = each.value["interface_name_02"]
  interface_privateip_allocation_02 = each.value["interface_privateip_allocation_02"]
  //interface_privateip_address_02    = each.value["interface_privateip_address_02"]


  # #############################################################################
  # PALO ALTO NIC UNTRUST
  # #############################################################################

  interface_name_03                 = each.value["interface_name_03"]
  interface_config_name_03          = each.value["interface_config_name_03"]
  interface_privateip_allocation_03 = each.value["interface_privateip_allocation_03"]
  //interface_privateip_address_03    = each.value["interface_privateip_address_03"]


  # #############################################################################
  # PALO ALTO VIRTUAL MACHINE
  # #############################################################################

  vm_name_01            = each.value["vm_name_01"]
  vm_size_01            = each.value["vm_size_01"]
  vm_osdisk_name_01     = each.value["vm_osdisk_name_01"]
  vm_image_publisher_01 = each.value["vm_image_publisher_01"]
  vm_image_offer_01     = each.value["vm_image_offer_01"]
  vm_image_sku_01       = each.value["vm_image_sku_01"]
  vm_image_version_01   = each.value["vm_image_version_01"]
  zones                 = each.value["zones"]

  tags = var.tags

}