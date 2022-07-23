
resource "azurerm_storage_account" "storageaccount" {
  name                     = var.storagename
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

    depends_on = [
      azurerm_resource_group.terraform-grp
    ]

}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}