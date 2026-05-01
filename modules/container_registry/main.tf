resource "random_string" "acr_suffix" {
  length  = 10
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_container_registry" "acr" {
  name                          = "${var.acr_name}${random_string.acr_suffix.result}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.acr_sku
  admin_enabled                 = var.acr_admin_enabled
  public_network_access_enabled = var.acr_public_network_access_enabled
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.principal_id
}