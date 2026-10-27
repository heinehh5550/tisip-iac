terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.40.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70" # Add your subscription ID here (found in Azure Portal) - Or use Windows environment variable AZURE_SUBSCRIPTION_ID / MacOS/Linux environment variable AZURE_SUBSCRIPTION_ID
}

variable "location" {
    type = string
    description = "Deployment location"
    default = "West Europe"
  
}

variable "rgname" {
    type = string
    description = "Resource Group Name"
    default = "rg-demo-terraform"
  
}
variable "saname" {
    type = string
    description = "Storage Account Name"
  
}
resource "azurerm_resource_group" "rg-sa" {
  name     = var.rgname
  location = var.location
}



resource "azurerm_storage_account" "sa-demo" {
  name                     = var.saname
  resource_group_name      = azurerm_resource_group.rg-sa.name
  location                 = azurerm_resource_group.rg-sa.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}