module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = "aiplayground"
}

module "resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm//examples/complete"
  location = var.location
  name     = module.naming.resource_group.name
}