
#enforce specific version

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.111.0"
    }
  }
}




# SP details and where to deploy etc

provider "azurerm" {
  features {}
  client_id       = "YOUR_CLIENT_ID"
  client_secret   = "YOUR_CLIENT_SECRET"
  tenant_id       = "YOUR_TENANT_ID"
  subscription_id = "YOUR_SUBSCRIPTION_ID"
}



resource "azurerm_resource_group" "db_hackathon" {
  name     = "db-hackathon"
  location = "East US"
}

resource "azurerm_virtual_network" "aro_vnet" {
  name                = "aro-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.db_hackathon.location
  resource_group_name = azurerm_resource_group.db_hackathon.name
}

resource "azurerm_subnet" "master_subnet" {
  name                 = "master-subnet"
  resource_group_name  = azurerm_resource_group.db_hackathon.name
  virtual_network_name = azurerm_virtual_network.aro_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "worker_subnet" {
  name                 = "worker-subnet"
  resource_group_name  = azurerm_resource_group.db_hackathon.name
  virtual_network_name = azurerm_virtual_network.aro_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.ContainerRegistry"]
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.db_hackathon.location
  resource_group_name = azurerm_resource_group.db_hackathon.name
}

resource "azurerm_subnet_network_security_group_association" "master" {
  subnet_id                 = azurerm_subnet.master_subnet.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_subnet_network_security_group_association" "worker" {
  subnet_id                 = azurerm_subnet.worker_subnet.id
  network_security_group_id = azurerm_network_security_group.example.id
}


# if needed 
resource "azurerm_network_security_rule" "example" {
  name                        = "example-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_resource_group.db_hackathon.id
  role_definition_name = "Contributor"
  principal_id         = "XXXXXX" # Service principal ID
}

resource "azurerm_openshift_cluster" "example" {
  name                = "example-openshift-cluster"
  location            = azurerm_resource_group.db_hackathon.location
  resource_group_name = azurerm_resource_group.db_hackathon.name

  cluster_profile {
    pull_secret      = "XXXXXX" # usual RH pull secret
    domain           = "example.com"
    resource_group_id = azurerm_resource_group.db_hackathon.id
  }

  service_principal {
    client_id     = "XXXXXX"
    client_secret = "XXXXXX"
  }

  network_profile {
    pod_cidr      = "10.128.0.0/14"
    service_cidr  = "172.30.0.0/16"
  }

  master_profile {
    vm_size     = "Standard_D8s_v3"
    subnet_id   = azurerm_subnet.master_subnet.id
  }

  worker_profile {
    name       = "worker"
    vm_size    = "Standard_D4s_v3"
    subnet_id  = azurerm_subnet.worker_subnet.id
    count      = 3
  }
}

