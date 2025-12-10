terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "6441c56f-2b11-456a-a0a1-aaa259e27929"
  tenant_id       = "1af9d088-6d24-471e-a766-637ca6ad2be8"
}
