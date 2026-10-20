#############################################################################
# LINUX VIRTUAL MACHINE MODULE PROMETHEUS
#############################################################################

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.3"
    }
  }
}

resource "random_password" "password_prometheus" {
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "vm_secret_prometheus" {
  name         = var.secret_name
  value        = random_password.password_prometheus.result
  key_vault_id = var.keyvault_id

  tags = var.commom_tags
}

resource "azurerm_network_interface" "nic_prometheus" {
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
resource "azurerm_linux_virtual_machine" "linux_vm_prometheus" {
  name                            = var.vm_name
  computer_name                   = var.computer_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = random_password.password_prometheus.result
  network_interface_ids = [
    azurerm_network_interface.nic_prometheus.id
  ]

  os_disk {
    name                 = "${var.vm_name}-disk"
    disk_size_gb         = "50"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal" //"0001-com-ubuntu-server-jammy"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  user_data = base64encode(<<-EOF
                #!/bin/bash
                # ---> Updating, upgrating and installing the base
                sudo apt update
                sudo timedatectl set-timezone America/Santiago
                sudo apt install lsb-release python3-pip python3-opencv apt-transport-https ca-certificates curl software-properties-common nfs-common -y
                sudo mkdir /var/lib/docker                               
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
                sudo apt update && sudo apt upgrade -y
                sudo apt install docker-ce -y

                sudo usermod -aG docker ubuntu
                sudo usermod -aG docker root

                #download plugin
                sudo mkdir -p ~/.docker/cli-plugins/
                sudo curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
                #set correct permissions
                sudo chmod +x ~/.docker/cli-plugins/docker-compose
                #check version
                sudo docker compose version

                sudo mkdir -p /opt/prometheus/prometheus/config
                sudo mkdir -p /opt/prometheus/data/prometheus
                sudo chmod -R 777 /opt/prometheus  
                
                
                CONF_PROMETHEUS=/opt/prometheus/prometheus/config/prometheus.yml
                : > $CONF_PROMETHEUS
                cat > $CONF_PROMETHEUS <<-EOT
                global:
                  scrape_interval: 30s
                  evaluation_interval: 30s # Evaluate rules every 15 seconds. The default is every 1 minute.
                  # scrape_timeout is set to the global default (10s).
                  scrape_timeout: 10s
                scrape_configs:
                  - job_name: 'prometheus_aks'
                    scrape_interval: 30s
                    scrape_timeout: 30s
                    honor_labels: true
                    metrics_path: '/federate'
                    scheme: http
                    #authorization:
                    #  credentials_file: '/etc/prometheus/credential.file'
                    # tls_config:
                    #   insecure_skip_verify: true
                    params:
                      'match[]':
                        - '{__name__=~".*"}'
                    metric_relabel_configs:
                      - action: labeldrop
                        regex: 'prometheus_replica|id|name'
                    static_configs:
                      - targets:
                        - '10.0.171.148:9090'
                        labels:
                          cluster: logista_aks
                          environment: prod
                EOT


                sudo docker run -d -p 9090:9090 -v /opt/prometheus/prometheus/config/prometheus.yml:/etc/prometheus/prometheus.yml -v /opt/prometheus/data/prometheus:/prometheus  prom/prometheus
                EOF
  )

  tags = var.commom_tags

  //depends_on = [azurerm_public_ip.prometheus]
}

#############################################################################
# DATA COLLECTION RULE ASSCIATION TO WINDOWS VIRTUAL MACHINE
#############################################################################


resource "azurerm_monitor_data_collection_rule_association" "dcr_assoc" {
  name                    = "dcr_association"
  target_resource_id      = azurerm_linux_virtual_machine.linux_vm_prometheus.id
  data_collection_rule_id = var.dcr_assoc_id
}

resource "azurerm_monitor_data_collection_rule_association" "dcr_vminsight_assoc" {
  name                    = "dcr_vm_insight_association"
  target_resource_id      = azurerm_linux_virtual_machine.linux_vm_prometheus.id
  data_collection_rule_id = var.dcr_vminsight_assoc_id
}



