variable "client_id" {
    type = string
    default = "c3b08a33-f32a-4f91-826d-6901e0738b7e"
}


variable "client_password" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
    default = "uksouth"
}

variable "cluster_name" {
    type = string
    default = "arocluster"
}

variable "cluster_domain" {
    type = string
    default = "azure-db"
}

variable "cluster_version" {
    type = string
    default = "4.14.16"
}

// Needs to be passed in to the cli, format should be:
// '{"auths":{"cloud.openshift.com":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"quay.io":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"registry.connect.redhat.com":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"},"registry.redhat.io":{"auth":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=","email":"someone@redhat.com"}}}'
variable "pull_secret" {
    type = string
}
