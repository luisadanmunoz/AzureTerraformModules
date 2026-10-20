#############################################################################
# MANAGEMENT GROUP - INTERMEDIATE ROOT
#############################################################################

data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "current" {
  name = "01d30fc7-1354-46cc-a9b2-b065333ce14b"
}


resource "azurerm_management_group" "Intermediate_Root" {
  display_name               = var.name_management_group_Intermediate_Root
  parent_management_group_id = data.azurerm_management_group.current.id //"/providers/Microsoft.Management/managementGroups/01d30fc7-1354-46cc-a9b2-b065333ce14b"
  subscription_ids           = var.subscription_ids_Intermediate_Root != null ? var.subscription_ids_Intermediate_Root : null

}

#############################################################################
# MANAGEMENT GROUP - PLATFORM
#############################################################################

resource "azurerm_management_group" "Platform" {
  display_name               = var.name_management_group_Platform
  parent_management_group_id = azurerm_management_group.Intermediate_Root.id //var.parent_management_group_id_Platform != null ? var.parent_management_group_id_Platform : null
  subscription_ids           = var.subscription_ids_Platform != null ? var.subscription_ids_Platform : null

  depends_on = [azurerm_management_group.Intermediate_Root]
}

#############################################################################
# MANAGEMENT GROUP - IDENTITY
#############################################################################

resource "azurerm_management_group" "Identity" {
  display_name               = var.name_management_group_Identity
  parent_management_group_id = azurerm_management_group.Platform.id //var.parent_management_group_id_Identity != null ? var.parent_management_group_id_Identity : null
  subscription_ids           = var.subscription_ids_Identity != null ? var.subscription_ids_Identity : null

  depends_on = [azurerm_management_group.Platform]
}

#############################################################################
# MANAGEMENT GROUP - MANAGEMENT
#############################################################################

resource "azurerm_management_group" "Management" {
  display_name               = var.name_management_group_Management
  parent_management_group_id = azurerm_management_group.Platform.id //var.parent_management_group_id_Management != null ? var.parent_management_group_id_Management : null
  subscription_ids           = var.subscription_ids_Management != null ? var.subscription_ids_Management : null

  depends_on = [azurerm_management_group.Platform]
}

#############################################################################
# MANAGEMENT GROUP - CONNECTIVIY
#############################################################################

resource "azurerm_management_group" "Connectivity" {
  display_name               = var.name_management_group_Connectivity
  parent_management_group_id = azurerm_management_group.Platform.id //var.parent_management_group_id_Connectivity != null ? var.parent_management_group_id_Connectivity : null
  subscription_ids           = var.subscription_ids_Connectivity != null ? var.subscription_ids_Connectivity : null

  depends_on = [azurerm_management_group.Platform]
}

#############################################################################
# MANAGEMENT GROUP - LANDING ZONES
#############################################################################

resource "azurerm_management_group" "Landing_Zones" {
  display_name               = var.name_management_group_Landing_Zones
  parent_management_group_id = azurerm_management_group.Intermediate_Root.id //var.parent_management_group_id_Landing_Zones != null ? var.parent_management_group_id_Landing_Zones : null
  subscription_ids           = var.subscription_ids_Landing_Zones != null ? var.subscription_ids_Landing_Zones : null

  depends_on = [azurerm_management_group.Platform]
}