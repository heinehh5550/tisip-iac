output "subnet_id" {
  value       = azurerm_subnet.snet.id
  description = "ID til subnettet, til bruk for f.eks. en NIC."
}

output "subnet_name" {
  description = "Navnet på subnettet."
  value = azurerm_subnet.snet.name
}