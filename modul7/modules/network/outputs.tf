output "subnet_id" {
  value       = azurerm_subnet.snet.id
  description = "ID til subnettet, til bruk for f.eks. en NIC."
}

output "subnet_name" {
  description = "Navnet på subnettet."
  value = azurerm_subnet.snet.name
}

output "vnet_name" {
  description = "Navnet på det virtuelle nettverket."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "ID til det virtuelle nettverket."
  value       = azurerm_virtual_network.vnet.id
}