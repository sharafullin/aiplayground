terraform {
    required_version = "~> 1.9"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
        }
    }
}

provider "azurerm" {
    features {

    }
    subscription_id = "534f3f2d-a4b5-4218-96ad-1b90beb94e1b"
}

provider "random" {}