#############################################################################
# PROVIDER RANDOM
#############################################################################
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.3"
    }
  }
}
#############################################################################
# RANDOM PASSWORD
#############################################################################
resource "random_password" "password_grafana" {
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
#############################################################################
# KEY VAULT SECRET
#############################################################################
resource "azurerm_key_vault_secret" "vm_secret_grafana" {
  name         = var.secret_name
  value        = random_password.password_grafana.result
  key_vault_id = var.keyvault_id

  tags = var.commom_tags
}
#############################################################################
# VM LINUX GRAFANA - NETWORK INTERFACE
#############################################################################
resource "azurerm_network_interface" "nic_grafana" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = (var.private_ip_address_allocation == "Static" ? var.private_ip_address : null)
    //public_ip_address_id = var.public_ip_address_id
  }
}
#############################################################################
# VM LINUX GRAFANA
#############################################################################
resource "azurerm_linux_virtual_machine" "linux_vm_grafana" {
  name                            = var.vm_name
  computer_name                   = var.computer_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = random_password.password_grafana.result
  network_interface_ids = [
    azurerm_network_interface.nic_grafana.id
  ]

  os_disk {
    name                 = "${var.vm_name}-disk"
    disk_size_gb         = "50"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }



  source_image_reference {
    publisher = "Canonical"
    #offer     = "UbuntuServer"
    offer = "0001-com-ubuntu-server-jammy"
    #sku     = "16.04-LTS"
    sku     = "22_04-lts"
    version = "latest"
  }

  user_data = base64encode(<<-EOF
                #!/bin/bash
                # ---> Updating, upgrating and installing the base
                sudo apt update
                sudo timedatectl set-timezone America/Santiago
                sudo apt install  net-tools lsb-release python3-pip python3-opencv apt-transport-https ca-certificates curl software-properties-common nfs-common -y
                sudo mkdir /var/lib/docker                               
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
                # Añadir el repositorio de Grafana
                sudo echo "deb https://packages.grafana.com/oss/deb stable main" >  /etc/apt/sources.list.d/grafana.list
                # Importar la clave GPG del repositorio de Grafana
                sudo curl https://packages.grafana.com/gpg.key | sudo apt-key add -
                # Actualizar el sistema de nuevo para reconocer el nuevo repositorio
                
                sudo apt update && sudo apt upgrade -y
                sudo apt install grafana docker-ce -y
                sudo systemctl status docker
                sudo usermod -aG docker ubuntu
                sudo usermod -aG docker root                
                
                
                DATA_SOURCE=/etc/grafana/provisioning/datasources/prometheus.yaml
                : > $DATA_SOURCE
                cat > $DATA_SOURCE <<-EOT
                # config file version
                apiVersion: 1

                # list of datasources to insert/update depending
                # whats available in the database
                datasources:
                  # <string, required> name of the datasource. Required
                - name: 'Prometheus'
                  type: 'prometheus'
                  access: 'proxy'
                  org_id: 1
                  url: "http://20.234.135.78:9090"
                  is_default: true
                  version: 1
                  editable: true
                EOT


                sudo systemctl enable grafana-server
                sudo systemctl start grafana-server
                EOF
  )

  //depends_on = [azurerm_public_ip.prometheus]

  tags = var.commom_tags

}



