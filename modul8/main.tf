terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
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
  source                = "./modules/network"
  project               = var.project
  name_prefix           = local.name_prefix
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  address_space         = ["10.0.0.0/16"]
  subnet_address_prefix = ["10.0.1.0/24"]
  tags                  = local.common_tags

}
