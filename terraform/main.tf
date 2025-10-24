module "rg-test" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name = "rg-test"
  location = var.location
}

module "ai_foundry" {
  source = "Azure/avm-ptn-aiml-ai-foundry/azurerm"

  # required inputs
  project_prefix      = "myproject"
  location            = var.location
  resource_group_name = rg-test.name
}