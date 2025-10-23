terraform {
    required_version = "~> 1.9"
    required_providers {

    }
}

provider "azurerm" {
    features {

    }
    use_msi = true 
    msi_client_id = "02a1c267-adfa-498a-a0ea-b058f6373ca9"
    subscription_id = "534f3f2d-a4b5-4218-96ad-1b90beb94e1b"
}