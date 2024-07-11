

# This installation  assumes a subscription that has the required registrations against it as per : https://learn.microsoft.com/en-us/azure/openshift/create-cluster?tabs=azure-cli
# Where XXXX replace as per instructions

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }

  // Backend state is recommended but not required, this block can be removed for testing environments. To use it , set up a storage account on Azure , create a container and reference the details on the block below
  backend "azurerm" {
    resource_group_name   = "XXXX"
    storage_account_name  = "XXXX"
    container_name        = "XXXX"
    key                   = "XXXX"
  }
}

#Skips regs as mentioned in the start - alternatively regs can be done here 

provider "azurerm" {
  features {}

  skip_provider_registration = true
}





####################
# Reference your Service Principal - it has to have MS Graph API directory read permissions as well as be a contributor on the sub level
####################

data "azuread_service_principal" "OpenShift_Service_Principal" {
  client_id = "XXXX"
}



data "azuread_service_principal" "redhatopenshift" {
  // This is the Azure Red Hat OpenShift RP service principal id - USE it as is 
  client_id = "f1dd0a37-89c6-4e07-bcd1-ffd3d43d8875"
}

####################
# Create Resource Groups
####################

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}


####################
# Create Virtual Network
####################

resource "azurerm_virtual_network" "example" {
  name                = "aro-cluster-vnet"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "main_subnet" {
  name                 = "main-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/23"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "worker_subnet" {
  name                 = "worker-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/23"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
}

####################
# Setup Network Roles
####################


resource "azurerm_role_assignment" "role_network1" {
  scope                = azurerm_virtual_network.example.id
  role_definition_name = "Network Contributor"
  // Note: remove "data." prefix to create a new service principal
  principal_id         = data.azuread_service_principal.redhatopenshift.object_id
}

resource "azurerm_role_assignment" "role_network2" {
  scope                = azurerm_virtual_network.example.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.OpenShift_Service_Principal.object_id
}

####################
# Create Azure Red Hat OpenShift Cluster
####################

resource "azurerm_redhat_openshift_cluster" "example" {
  name                = var.cluster_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  cluster_profile {
    domain = var.cluster_domain
    version = var.cluster_version
    pull_secret = var.pull_secret
  }
  network_profile {
    pod_cidr     = "10.128.0.0/14"
    service_cidr = "172.30.0.0/16"
  }

  main_profile {
    vm_size   = "Standard_D8s_v3"
    subnet_id = azurerm_subnet.main_subnet.id
  }

  api_server_profile {
    visibility = "Public"
  }

  ingress_profile {
    visibility = "Public"
  }

  worker_profile {
    vm_size      = "Standard_D4s_v3"
    disk_size_gb = 128
    node_count   = 3
    subnet_id    = azurerm_subnet.worker_subnet.id
  }

  service_principal {
    client_id     = "XXXX"
    client_secret = var.client_password
  }

  depends_on = [
    azurerm_role_assignment.role_network1,
    azurerm_role_assignment.role_network2,
  ]
}

####################
# Output Console URL
####################

output "console_url" {
  value = azurerm_redhat_openshift_cluster.example.console_url
}
