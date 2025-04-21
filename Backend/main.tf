terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.18.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "rg-backend-tfstate-marcusk"
    storage_account_name = "sabackendmarcusk1"
    container_name = "sc-backend-marcusk1"
    key = "marcusktfstate01"
  }
}
provider "azurerm" {
  subscription_id = "efc1e7b1-5729-4eea-b33e-12cc6b1c0183"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}


resource "azurerm_resource_group" "rg-backend-marcusk" {
  name     = var.rg_backend_name
  location = var.rg_backend_location
}

resource "azurerm_storage_account" "sa-backend-marcusk" {
  name                     = var.sa_backend_name
  resource_group_name      = var.rg_backend_name
  location                 = var.rg_backend_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc_backend_marcusk" {
  name                  = var.sc_backend_name
  storage_account_id    = azurerm_storage_account.sa-backend-marcusk.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_backend_marcusk" {
  name                        = var.kv_backend_name
  location                    = var.rg_backend_location
  resource_group_name         = var.rg_backend_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create"
    ]

    secret_permissions = [
      "Get", "Set", "List"
    ]

    storage_permissions = [
      "Get", "Set", "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_accesskey" {
  name         = var.sa_backend_acceskey_name
  value        = azurerm_storage_account.sa-backend-marcusk.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend_marcusk.id
}
