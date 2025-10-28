module "name" {
  source = "./modules/vnet"

  vnet_name           = "vent-dev"
  address_space       = ["192.168.0.0/26"]
  location            = "Central India "
  resource_group_name = "sandbox_rg"
  tags = {
    environment = "dev"
    project     = "tf_azure"
  }
  subnets = [{
    name             = "mgmt"
    address_prefixes = ["192.168.0.0/28"]
    },
    {
      name             = "app"
      address_prefixes = ["192.168.0.16/28"]
  }]
}