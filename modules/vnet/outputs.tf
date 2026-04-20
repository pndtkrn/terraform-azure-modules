output "subnet_ids" {
  value = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}