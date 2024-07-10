variable "domain" {
  description = "Domain name or prefix for naming resources."
  type        = string
  default     = "example"
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group where resources will be deployed."
  type        = string
  default     = "aro-hackathon"
}

variable "virtual_network_address_space" {
  description = "Address space for the Azure Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "master_subnet_name" {
  description = "Name of the subnet for master nodes."
  type        = string
  default     = "master-subnet"
}

variable "master_subnet_address_space" {
  description = "Address space for the subnet for master nodes."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "worker_subnet_name" {
  description = "Name of the subnet for worker nodes."
  type        = string
  default     = "worker-subnet"
}

variable "worker_subnet_address_space" {
  description = "Address space for the subnet for worker nodes."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "aro_cluster_aad_sp_object_id" {
  description = "Object ID of the Azure AD service principal for the ARO cluster."
  type        = string
}

variable "aro_rp_aad_sp_object_id" {
  description = "Object ID of the Azure AD service principal for ARO resource provider."
  type        = string
}

variable "pod_cidr" {
  description = "CIDR block for pods in the ARO cluster."
  type        = string
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  description = "CIDR block for services in the ARO cluster."
  type        = string
  default     = "10.0.0.0/16"
}

variable "pull_secret" {
  description = "Pull secret for accessing Red Hat container images."
  type        = string
}

variable "master_node_vm_size" {
  description = "VM size for master nodes in the ARO cluster."
  type        = string
  default     = "Standard_D8s_v3"
}

variable "master_encryption_at_host" {
  description = "Enable encryption at host for master nodes."
  type        = bool
  default     = false
}

variable "worker_profile_name" {
  description = "Name for worker node profile in the ARO cluster."
  type        = string
  default     = "workerpool"
}

variable "worker_node_vm_size" {
  description = "VM size for worker nodes in the ARO cluster."
  type        = string
  default     = "Standard_D4s_v3"
}

variable "worker_node_vm_disk_size" {
  description = "Disk size in GB for worker nodes in the ARO cluster."
  type        = number
  default     = 128
}

variable "worker_node_count" {
  description = "Number of worker nodes in the ARO cluster."
  type        = number
  default     = 3
}

variable "worker_encryption_at_host" {
  description = "Enable encryption at host for worker nodes."
  type        = bool
  default     = false
}

variable "api_server_visibility" {
  description = "Visibility mode for API server."
  type        = string
  default     = "Public"
}

variable "ingress_profile_name" {
  description = "Name for ingress profile in the ARO cluster."
  type        = string
  default     = "ingress"
}

variable "ingress_visibility" {
  description = "Visibility mode for ingress."
  type        = string
  default     = "Public"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
