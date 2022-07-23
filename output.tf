output "resource_group_name" {
  description = "The name of new resource group"
  value       = azurerm_resource_group.terraform-grp.name
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = azurerm_virtual_network.vnet.subnet[0].id
}