locals {
  resource_group_name = "terraform-grp"
  location = "Central India"
  virtual_network = {
    name = "vnet1"
    address_space = "172.16.0.0/16"
 }
  subnets = [
      {
          name = "subnetA"
          address_prefixes = "172.16.0.0/24"
      },
      {
          name = "subnetB"
          address_prefixes = "172.16.1.0/24"
      }
      ]
}
