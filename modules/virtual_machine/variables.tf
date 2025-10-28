variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create resources."
  type        = string
}

variable "nic" {
  description = "A set of network interface configurations for the virtual machine."
  type = set(object({
    nic_name                      = string
    ip_configuration_name         = string
    subnet_id                     = string
    private_ip_address            = optional(string)
    private_ip_address_allocation = string
  }))
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "image_publisher" {
  description = "The publisher of the image used for the virtual machine."
  type        = string
}

variable "image_offer" {
  description = "The offer of the image used for the virtual machine."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the image used for the virtual machine."
  type        = string
}

variable "image_version" {
  description = "The version of the image used for the virtual machine."
  type        = string
}
variable "image_sku" {
  description = "The SKU of the image used for the virtual machine."
  type        = string
}

variable "image_version" {
  description = "The version of the image used for the virtual machine."
  type        = string
}

variable "storage_os_disk_name" {
  description = "The name of the OS disk."
  type        = string
}

variable "storage_os_disk_caching" {
  description = "The caching type for the OS disk."
  type        = string
}

variable "storage_os_disk_create_option" {
  description = "The create option for the OS disk."
  type        = string
}

variable "storage_os_disk_managed_disk_type" {
  description = "The managed disk type for the OS disk."
  type        = string
}