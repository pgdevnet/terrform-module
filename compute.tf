resource "azurerm_network_interface" "terraform-nic" {
  name                = var.vm_nic_name
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_virtual_network.vnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_resource_group.terraform-grp
  ]

}

resource "tls_private_key" "linuxkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "linuxpemkey" {
    filename = "linuxkey.pem"
    content = tls_private_key.linuxkey.private_key_pem
    depends_on = [
      tls_private_key.linuxkey
    ]
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = var.linux_vm_name
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "piyush"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.linuxkey.private_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.terraform-nic,
    azurerm_resource_group.terraform-grp,
    tls_private_key.linuxkey
  ]
}