

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    netapp-cloudmanager = {
      source = "NetApp/netapp-cloudmanager"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

provider "netapp-cloudmanager" {
  refresh_token = var.token
}

data "azurerm_subscription" "current" {
}

output "current_subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}

output "current_subscription_display_id" {
  value = data.azurerm_subscription.current.id
}


resource "netapp-cloudmanager_cvo_azure" "cl-azure" {
  //depends_on = [azurerm_role_assignment.occm-role-assignment]
  provider = netapp-cloudmanager
  name = "ManagedServiceIdentity"
  location = "westeurope"
  availability_zone = 2
  subscription_id = "2883c151-e6c4-413d-bacb-211c0e8916d4"
  subnet_id = "subnet-eu-west-pro-bluexp-03"
  vnet_id = "vnet-eu-west-pro-services-01"
  vnet_resource_group = "rg-eu-west-pro-comm-03"
  data_encryption_type = "AZURE"
  azure_tag {
              tag_key = "abcd"
              tag_value = "ABCD"
            }
  azure_tag {
              tag_key = "xxx"
              tag_value = "YYY"
            }
  storage_type = "Premium_LRS"
  svm_password = "P@ssword!18"
  client_id = "nQ1prMHN6NOZzP9DlJiK3OYIjtrY222m"
  workspace_id = "workspace-t65mEgbU" 
  writing_speed_state = "NORMAL"
  is_ha = false
  //worm_retention_period_length = 2
  //worm_retention_period_unit = "days"
  capacity_package_name = "Freemium"
}

/*
resource "netapp-cloudmanager_cvo_azure" "cl-azure" {
  //depends_on = [azurerm_role_assignment.occm-role-assignment]
  provider = netapp-cloudmanager
  name = "TFConnectorAzure"
  location = "westeurope"
  availability_zone = 2
  subscription_id = "2883c151-e6c4-413d-bacb-211c0e8916d4"
  vnet_id = "vnet-eu-west-pro-services-01"
  vnet_resource_group = "rg-eu-west-pro-comm-03"
  data_encryption_type = "AZURE"
  azure_tag {
              tag_key = "abcd"
              tag_value = "ABCD"
            }
  azure_tag {
              tag_key = "xxx"
              tag_value = "YYY"
            }
  storage_type = "Premium_LRS"
  svm_password = "P@assword!"
  client_id = "/subscriptions/2883c151-e6c4-413d-bacb-211c0e8916d4/resourceGroups/rg-eu-west-pro-comm-03/providers/Microsoft.Compute/virtualMachines/TFConnectorAzure"
  subnet_id = "subnet-eu-west-pro-bluexp-03"
  workspace_id = "workspace-fdgsgNse"
  capacity_tier = "Blob"
  writing_speed_state = "NORMAL"
  is_ha = false
  azure_encryption_parameters {
     key = "key1"
     vault_name = "vaulta"
     user_assigned_identity = "abcManagedIdDev"
  }
}
*/
