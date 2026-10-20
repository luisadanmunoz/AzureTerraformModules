# Compute Azure con Terraform

Catalogo base de compute para Azure siguiendo la misma estructura que `Networking`, `Gobernanza`, `Seguridad` y `Almacenamiento`.

## Modulos incluidos

- `rg`
- `ssh_public_key`
- `proximity_placement_group`
- `availability_set`
- `managed_disk`
- `linux_virtual_machine`
- `windows_virtual_machine`
- `virtual_machine_data_disk_attachment`
- `virtual_machine_extension`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- usa `ssh_public_key`, `proximity_placement_group` y `availability_set` como recursos base del stack de compute
- usa `managed_disk` cuando quieras desacoplar los discos de datos de la maquina virtual
- usa `linux_virtual_machine` o `windows_virtual_machine` cuando ya tengas disponibles los `network_interface_ids`
- usa `virtual_machine_data_disk_attachment` cuando el disco y la maquina ya existan en el mismo plan o cuando aportes los ids directos
- usa `virtual_machine_extension` cuando quieras extender una VM de Linux o Windows desde el mismo catalogo
- usa `network_interface_ids` directos, porque la red suele vivir en el stack de networking

## Ejemplos de extensiones

- `env/virtual_machine_extension.dev.tfvars`: ejemplo base con `CustomScript`
- `env/virtual_machine_extension_aad_login_linux.dev.tfvars`: ejemplo para `AADSSHLoginForLinux`
- `env/virtual_machine_extension_aad_login_windows.dev.tfvars`: ejemplo para `AADLoginForWindows`
- `env/virtual_machine_extension_azure_monitor_linux_agent.dev.tfvars`: ejemplo para `AzureMonitorLinuxAgent`
- `env/virtual_machine_extension_azure_monitor_windows_agent.dev.tfvars`: ejemplo para `AzureMonitorWindowsAgent`
- `env/virtual_machine_extension_iaas_antimalware.dev.tfvars`: ejemplo para `IaaSAntimalware`

## Notas de uso para extensiones

- `AADSSHLoginForLinux` y `AADLoginForWindows` suelen requerir identidad administrada en la VM y roles RBAC de login
- `AzureMonitorLinuxAgent` y `AzureMonitorWindowsAgent` suelen desplegarse junto con una Data Collection Rule o su asociacion
- `IaaSAntimalware` aplica a Windows y suele usar `settings` en formato objeto
