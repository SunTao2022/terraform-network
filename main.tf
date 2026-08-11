terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatetao202607022027"
    container_name       = "tfstate"
    key                  = "terraform-network.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "./modules/network"

  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  web_cidr            = var.web_cidr
  db_cidr             = var.db_cidr
}

