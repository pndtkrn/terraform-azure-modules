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

variable "create_availability_set" {
  description = "Set this to true to create an availability set and to false to not create one."
  type        = bool
  default     = false
}

variable "delete_os_disk_on_termination" {
  description = "Delete os disk on termination"
  type        = bool
  default     = false
}

variable "delete_data_disks_on_termination" {
  description = "Delete data disk on terminaton"
  type        = bool
  default     = false
}

variable "ssh_public_key" {
  description = "The SSH public key for VM authentication"
  type        = string
}

variable "assign_managed_identity" {
  description = "Whether to assign a managed identity to the VM"
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "The managed identity type assigned to the VM"
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "The identity_type value must be one of 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'."
  }
}

variable "identity_ids" {
  description = "The list of user assigned identity IDs to assign to the VM. This is required if identity_type is 'UserAssigned' or 'SystemAssigned, UserAssigned'."
  type        = list(string)
  default     = []
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

variable "storage_os_disk_name" {
  description = "The name of the OS disk."
  type        = string
}

variable "storage_os_disk_caching" {
  description = "The caching type for the OS disk."
  type        = string

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.storage_os_disk_caching)
    error_message = "The caching type for the OS disk must be one of 'None', 'ReadOnly', or 'ReadWrite'."
  }
}

variable "storage_os_disk_create_option" {
  description = "The create option for the OS disk."
  type        = string
}

variable "storage_os_disk_managed_disk_type" {
  description = "The managed disk type for the OS disk."
  type        = string
}

variable "custom_data_file_path" {
  description = "The path to the custom data file to be added to the VM."
  type        = string
  default     = null
}