locals {
  location          = "centralindia"
  resource_group    = "rg-sandbox"
  vnet_app_001_name = "vnet-app-002"
}

module "vnet_app_001" {
  source              = "../modules/vnet"
  vnet_name           = local.vnet_app_001_name
  location            = local.location
  resource_group_name = local.resource_group
  address_space       = ["172.16.0.0/24"]
  subnets = [
    {
      name             = "mgmt"
      address_prefixes = ["172.16.0.0/27"]
    },
    {
      name             = "app"
      address_prefixes = ["172.16.0.32/27"]
    }
  ]
}

# module "test_vm" {
#   source = "../modules/virtual_machine"
# }