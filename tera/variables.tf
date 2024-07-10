variable "client_id" {
    type = string
}


variable "client_password" {
    type = string
}

variable "resource_group_name" {
    type = string
    default = "aro-example-resource-group"
}

variable "location" {
    type = string
    default = "eastus"
}

variable "cluster_name" {
    type = string
    default = "MyExampleCluster"
}

variable "cluster_domain" {
    type = string
    default = ""
}

variable "cluster_version" {
    type = string
    default = "4.12.25"
}

// Needs to be passed in to the cli, format should be:
// '{"auths":{"cloud.openshift.com":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"quay.io":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"registry.connect.redhat.com":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"registry.redhat.io":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"}}}'
variable "pull_secret" {
    type = string
}
