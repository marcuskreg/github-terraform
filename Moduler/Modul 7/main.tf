resource "azurerm_resource_group" "rg-modul-7" {
  name     = local.rgname
  location = var.location
}


resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}


resource "azurerm_storage_account" "sa-modul-7" {
  name                     = "${var.saname}storage${random_string.storage_suffix.result}"
  resource_group_name      = local.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


  static_website {
    index_document = var.indexdocument
  }
}

resource "azurerm_storage_blob" "indexmodul7" {
  name                   = var.indexdocument
  storage_account_name   = azurerm_storage_account.sa-modul-7.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = var.sourcecontent
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa-modul-7.primary_web_endpoint
}