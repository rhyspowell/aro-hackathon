# Running Instructions

To allow for the storage of the terraform state a storage resource group, account name and container name need to be created manually.
Once created export the values

export STORAGE_RESOURCE_GROUP_NAME=xxxxxxx
export STORAGE_ACCOUNT_NAME=xxxxxxx
export STORAGE_CONTAINER_NAME=tfstate
export STORAGE_KEY=xxxxxx

Fill your terraform.tfvars file with the required data. Check with the variable file for the ones that are required, they have no defaults. The ones with defaults can be overridden by adding your required values within the tfvars file as well.