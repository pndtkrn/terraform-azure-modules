resource "azurerm_network_interface" "nic" {
  for_each            = { for nic in var.nic : nic.nic_name => nic }
  name                = each.value.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = each.value.subnet_id
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}

resource "azurerm_availability_set" "availability_set" {
  name                         = "${var.vm_name}-as"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [for nic in azurerm_network_interface.nic : nic.id]
  vm_size               = var.vm_size

  availability_set_id = azurerm_availability_set.availability_set.id

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = var.storage_os_disk_name
    caching           = var.storage_os_disk_caching
    create_option     = var.storage_os_disk_create_option
    managed_disk_type = var.storage_os_disk_managed_disk_type
  }
}