module "rg-test" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name = "rg-test"
  location = var.location
}

module "rg-test2" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name = "rg-test2"
  location = var.location
}