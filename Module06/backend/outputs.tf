output "keyvault_name" {
  value = azurerm_key_vault.demo.name
}

output "storage_account_name" {
  description = "Navnet på state-kontoen. Nyttig i az storage blob list når du skal se hvilke states som finnes."
  value       = azurerm_storage_account.state.name
}

output "resource_group_name" {
  description = "Ressursgruppa backenden ligger i. Denne skal IKKE rives før faget er over."
  value       = azurerm_resource_group.backend.name
}

# Lim inn i ../backend.hcl
output "backend_hcl" {
  value = <<-EOT
    resource_group_name  = "${azurerm_resource_group.backend.name}"
    storage_account_name = "${azurerm_storage_account.state.name}"
    container_name       = "${azurerm_storage_container.tfstate.name}"
    use_azuread_auth     = true
  EOT
}