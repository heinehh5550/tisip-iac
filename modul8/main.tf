terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = local.common_tags
}

module "network" {
  source              = "git::https://github.com/heinehh5550/tisip-iac.git//modules/network?ref=network-v1.1.0"
  project             = var.project
  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags

}
