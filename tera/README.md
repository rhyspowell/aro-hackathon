# Running Instructions

To allow for the storage of the terraform state a storage resource group, account name and container name need to be created manually.
Once created  run terraform init with the required dynamic flags : terraform init   -backend-config="storage_account_name=XXXX"   -backend-config="resource_group_name=XXXX" -backend-config="container_name=XXXX" -backend-config="key=XXXX"
