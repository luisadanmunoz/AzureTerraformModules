# Terraform Module: Grafana VM

Este módulo de Terraform despliega una máquina virtual Linux en Azure con Grafana preinstalado y configurado.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.password_grafana`: Genera una contraseña aleatoria para Grafana.
- `azurerm_key_vault_secret.vm_secret_grafana`: Almacena la contraseña en Azure Key Vault.
- `azurerm_network_interface.nic_grafana`: Crea una interfaz de red para la VM.
- `azurerm_linux_virtual_machine.linux_vm_grafana`: Despliega la máquina virtual Linux con Grafana.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                           | Tipo        | Descripción                                                  | Por defecto |
|----------------------------------|------------|--------------------------------------------------------------|------------|
| `secret_name`                    | `string`   | Nombre del secreto en Key Vault.                            | -          |
| `keyvault_id`                    | `string`   | ID del Key Vault donde se almacenará la contraseña.        | -          |
| `commom_tags`                    | `map(any)` | Etiquetas comunes para los recursos.                        | `{}`       |
| `vm_name`                         | `string`   | Nombre de la máquina virtual.                               | -          |
| `location`                        | `string`   | Ubicación de la máquina virtual.                           | -          |
| `resource_group_name`             | `string`   | Nombre del grupo de recursos.                              | -          |
| `subnet_id`                       | `string`   | ID de la subred donde se desplegará la VM.                 | -          |
| `private_ip_address_allocation`   | `string`   | Método de asignación de la IP privada (Static/Dynamic).    | -          |
| `private_ip_address`              | `string`   | Dirección IP privada de la VM si se usa asignación estática. | -          |
| `size`                            | `string`   | Tamaño de la máquina virtual.                              | -          |
| `admin_username`                  | `string`   | Nombre del usuario administrador.                          | -          |
| `computer_name`                   | `string`   | Nombre del equipo dentro del sistema operativo.            | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "grafana" {
  source                        = "./ruta/al/modulo"
  secret_name                   = "grafana-secret"
  keyvault_id                   = "keyvault-id"
  commom_tags                   = { env = "prod" }
  vm_name                       = "grafana-vm"
  location                      = "East US"
  resource_group_name           = "mi-grupo-de-recursos"
  subnet_id                     = "subnet-id"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.0.10"
  size                          = "Standard_B2s"
  admin_username                = "admin"
  computer_name                 = "grafana-server"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la implementación de Grafana en Azure sobre una máquina virtual Linux.