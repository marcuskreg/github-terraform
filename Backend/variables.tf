variable "rg_backend_name" {
  type        = string
  description = "Resource group name"
}

variable "rg_backend_location" {
  type        = string
  description = "Default location"
  default     = "norwayeast"
}

variable "sa_backend_name" {
  type        = string
  description = "Storage account name"
}

variable "sc_backend_name" {
  type        = string
  description = "Storace container name"
}

variable "kv_backend_name" {
  type        = string
  description = "Key Vault name"
}

variable "sa_backend_acceskey_name" {
  type        = string
  description = "Acceskey name"
}