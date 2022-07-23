
resource "azurerm_resource_group" "terraform-grp" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_network_security_group" "terraform-nsg" {
  name                = var.nsg_name
  location            = local.location
  resource_group_name = local.resource_group_name

  dynamic "security_rules" {
    for_each = {for sg in var.security_rules : sg.name => sg }
    content {
        name                       = each.value.name
        priority                   = each.value.priority
        direction                  = each.value.direction
        access                     = each.value.access
        protocol                   = each.value.protocol
        source_port_range          = each.value.source_port_range
        destination_port_range     = each.value.destination_port_range
        source_address_prefix      = each.value.source_address_prefix
        destination_address_prefix = each.value.destination_address_prefix

    }
  }
  depends_on = [
    azurerm_resource_group.terraform-grp
  ]
}


resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.address_space

    dynamic "subnet" {
      for_each = { for sub in var.subnets : sub.name => sub }
      content {
        name           = each.value.name
        address_prefix = each.value.address_prefix
      }
    }

  depends_on = [
    azurerm_resource_group.terraform-grp
  ]
}

resource "azurerm_subnet_network_security_group_association" "NSG-associate" {
  subnet_id = azurerm_virtual_network.vnet.subnet[0].id
  network_security_group_id = azurerm_network_security_group.terraform-nsg.id
}


