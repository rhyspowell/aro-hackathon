# This installation  assumes a subscription that has the required registrations against it as per : https://learn.microsoft.com/en-us/azure/openshift/create-cluster?tabs=azure-cli
# Where XXXX replace as per instructions

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }

  // Backend state is recommended but not required, this block can be removed for testing environments. To use it , set up a storage account on Azure , create a container and reference the details on the block below
  backend "azurerm" {
    resource_group_name  = var.storage_resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = var.key
  }
}

#Skips regs as mentioned in the start - alternatively regs can be done here 

provider "azurerm" {
  features {}

  skip_provider_registration = true
}
