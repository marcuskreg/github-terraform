terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-backend-tfstate-marcusk"
    storage_account_name = "sabackendmarcusk1"
    container_name       = "sc-backend-marcusk1"
    key                  = "marcusktfstate01.rg.modul7"
  }
}

provider "azurerm" {
  subscription_id = "efc1e7b1-5729-4eea-b33e-12cc6b1c0183"
  features {
  }
}