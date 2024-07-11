variable "client_id" {
  type = string
}


variable "client_password" {
  type = string
}

variable "storage_resource_group_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "key" {
  type = string
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "cluster_name" {
  type    = string
  default = "arocluster"
}

variable "cluster_domain" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "4.14.16"
}

variable "vnet_ip_range" {
  type    = string
  default = "10.0.0.0/22"
}

variable "control_plane_range" {
  type    = string
  default = "10.0.0.0/23"
}

variable "worker_range" {
  type    = string
  default = "10.0.2.0/23"
}

// Needs to be passed in to the cli, format should be:
// '{"auths":{"cloud.openshift.com":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"quay.io":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"registry.connect.redhat.com":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"registry.redhat.io":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"}}}'
variable "pull_secret" {
  type = string
}
