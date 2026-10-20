# virtual_machine_extension

Despliega una extension reutilizable sobre una maquina virtual existente.

Ejemplos comunes dentro del stack:

- `CustomScript`
- `AADSSHLoginForLinux`
- `AADLoginForWindows`
- `AzureMonitorLinuxAgent`
- `AzureMonitorWindowsAgent`
- `IaaSAntimalware`

El modulo acepta `settings` y `protected_settings` como objeto o como string JSON.
