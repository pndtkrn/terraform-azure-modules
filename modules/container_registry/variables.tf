variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the container registry will be created."
  type        = string
}

variable "acr_sku" {
  description = "The SKU of the container registry"
  type        = string
  default     = "Standard"
}

variable "acr_admin_enabled" {
  description = "Whether to enable the admin user for the container registry."
  type        = bool
  default     = false
}

variable "principal_id" {
  description = "The principal ID to assign the AcrPull role to."
  type        = string
}

variable "acr_public_network_access_enabled" {
  description = "Whether to enable public network access for the container registry."
  type        = bool
  default     = false
}