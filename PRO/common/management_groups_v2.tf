#############################################################################
# MANAGEMENT GROUPS
#############################################################################

module "management_groups" {
  source = "../module/management_groups"

  for_each = var.management_groups

  #############################################################################
  # MANAGEMENT GROUPS - INTERMEDIATE ROOT
  #############################################################################

  name_management_group_Intermediate_Root = each.value["name_Intermediate_Root"]
  subscription_ids_Intermediate_Root      = lookup(each.value, "subscription_ids_Root", null)

  #############################################################################
  # MANAGEMENT GROUPS - PLATFORM
  #############################################################################

  name_management_group_Platform = each.value["name_Intermediate"]
  subscription_ids_Platform      = lookup(each.value, "subscription_ids_Platform", null)

  #############################################################################
  # MANAGEMENT GROUPS - IDENTITY
  ############################################################################# 

  name_management_group_Identity = each.value["name_Identity"]
  subscription_ids_Identity      = lookup(each.value, "subscription_ids_Identity", null)

  #############################################################################
  # MANAGEMENT GROUPS - MANAGEMENT
  ############################################################################# 

  name_management_group_Management = each.value["name_Management"]
  subscription_ids_Management      = lookup(each.value, "subscription_ids_Management", null)

  #############################################################################
  # MANAGEMENT GROUPS - CONNECTIVIY
  ############################################################################# 

  name_management_group_Connectivity = each.value["name_Connectivity"]
  subscription_ids_Connectivity      = lookup(each.value, "subscription_ids_Connectivity", null)

  #############################################################################
  # MANAGEMENT GROUPS - LANDING ZONE
  ############################################################################# 

  name_management_group_Landing_Zones = each.value["Landing_Zone"]
  subscription_ids_Landing_Zones      = lookup(each.value, "subscription_ids_Landing_Zone", null)

  #############################################################################
  # MANAGEMENT GROUPS - DECOMMISSIONED
  ############################################################################# 

  name_management_group_decommissioned = each.value["decommissioned"]
  subscription_ids_decommissioned      = lookup(each.value, "subscription_ids_decommissioned", null)

  #############################################################################
  # MANAGEMENT GROUPS - SANDBOX
  ############################################################################# 

  name_management_group_sandbox = each.value["sandbox"]
  subscription_ids_sandbox      = lookup(each.value, "subscription_ids_sandbox", null)

}