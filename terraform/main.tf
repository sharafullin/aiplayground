module "rg" {
    source  = "Azure/avm-res-resources-resourcegroup/azurerm"
    version = "0.2.1"

    name = "rg-test"
    location = var.location
}

module "ai_foundry" {
    source = "Azure/avm-ptn-aiml-ai-foundry/azurerm"

    base_name = "test"
    resource_group_resource_id = module.rg.resource_id
    location            = var.location

    ai_projects = {
    project_1 = {
      name                       = "project-1"
      description                = "Project 1 description"
      display_name               = "Project 1 Display Name"
      create_project_connections = false
    }
  }
}
