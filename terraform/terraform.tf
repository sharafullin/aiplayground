terraform {
    required_version = "~> 1.9"
    required_providers {
        azapi = {
            source  = "Azure/azapi"
            version = "~> 2.0"
        }
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.0"
        }
            random = {
            source  = "hashicorp/random"
            version = "~> 3.5"
        }
        time = {
            source  = "hashicorp/time"
            version = "~> 0.12"
        }

    }
}

provider "azurerm" {
    features {

    }
    subscription_id = "534f3f2d-a4b5-4218-96ad-1b90beb94e1b"
}