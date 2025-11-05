resource "azurerm_resource_group" "rg" {
  name     = "rg-aks"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "snet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.240.0.0/16"]
}

resource "azurerm_user_assigned_identity" "control_plane" {
  name                = "uai-control-plane"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_user_assigned_identity" "kubelet" {
  name                = "my-custom-kubelet-identity"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_role_assignment" "cp_assign_kubelet" {
  scope                = azurerm_user_assigned_identity.kubelet.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.control_plane.principal_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-local"
  sku_tier            = "Free"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_B2als_v2"
    vnet_subnet_id = azurerm_subnet.snet.id
     
  }

  kubelet_identity {
    user_assigned_identity_id = azurerm_user_assigned_identity.kubelet.id
    client_id = "00000000-0000-0000-0000-000000000000"
    object_id = "00000000-0000-0000-0000-000000000000"
    
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.control_plane.id]
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "acrvwjg37"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"            # Options: Basic, Standard, Premium

  admin_enabled       = true               # Optional, enables admin user + password
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_user_assigned_identity.kubelet.principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

output "acrname" {
    value = azurerm_container_registry.acr.name
}