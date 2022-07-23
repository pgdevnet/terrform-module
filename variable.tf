variable "subnets_no" {
    type = number
    description = "Please input no of subnets required"
    default = 2
}

variable "storagename" {
    type = string
    description = "Input name for stoarge account"
    default = "mystorage260985"
}


variable "security_rules" {
  description = "A list of security rules to be created."
  type = list(object({
    name      = string
    priority  = number
    direction = string 
    access    = string
    protocol  = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  }))
  default = [ {
    name = "allow-22"
    priority = 110
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  },
  {
    name = "allow-80"
    priority = 120
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
   ]
}

variable "subnets" {
  description = "A List of subnet to be created."
  type        = list(object({
      name = string
      address_prefix = string  
  }))
  default = [ {
    address_prefix = "subnetA"
    name = "172.16.1.0/24"
  },{
    address_prefix = "subnetB"
    name = "172.16.2.0/24"
  } ]
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "terraform-vnet1"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["172.16.0.0/16"]
}

variable "nsg_name" {
  description = "Name of the NSG to create"
  type        = string
  default     = "terraform-nsg"
}

variable "vm_nic_name" {
  description = "Name of the NIC to create"
  type        = string
  default     = "terraform-nic"
}

variable "linux_vm_name" {
  description = "Name of the Linux VM to create"
  type        = string
  default     = "terraform-linuxvm"
}