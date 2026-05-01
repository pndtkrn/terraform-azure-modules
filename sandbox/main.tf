locals {
  location          = "centralindia"
  resource_group    = "rg-sandbox"
  vnet_app_001_name = "vnet-app-001"
}

module "vnet_app_001" {
  source              = "../modules/vnet"
  vnet_name           = local.vnet_app_001_name
  location            = local.location
  resource_group_name = local.resource_group
  address_space       = ["10.0.0.0/25"]
  subnets = [
    {
      name             = "mgmt"
      address_prefixes = ["10.0.0.0/26"]
    },
    {
      name             = "app"
      address_prefixes = ["10.0.0.64/27"]
    }
  ]
}

# module "test_vm" {
#   source = "../modules/virtual_machine"
# }