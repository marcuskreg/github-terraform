variable "rgname" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Default location"
  default     = "norwayeast"
}

variable "saname" {
  type        = string
  description = "Storage account Name"
}

variable "indexdocument" {
  type        = string
  description = "Index Document Name"
}

variable "sourcecontent" {
  type        = string
  description = "Soruce Content"
}