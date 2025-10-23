terraform {
    required_version = "~> 1.9"
    required_providers {

    }
}

provider "azurerm" {
    features {

    }
    enable-oidc: true
    client_id       = "a8eb6959-65bd-46a7-ab16-67a02fc7663f"
    subscription_id = "534f3f2d-a4b5-4218-96ad-1b90beb94e1b"
    tenant_id       = "b8afe45d-a365-4f0a-837a-6493cdc22154"
}