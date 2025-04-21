locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  rgname = "${var.rgname}-${local.workspaces_suffix}"
}
