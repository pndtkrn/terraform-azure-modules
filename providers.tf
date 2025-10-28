terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.64.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "31daf5a2-6eff-4496-8c5b-22dbece4b8c4"
}
