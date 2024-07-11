# Running Instructions

To allow for the storage of the terraform state a storage resource group, a storage account and a container need to be created. The key will be created dynamically and thats the actual state file.

Once created run terraform initialise with the required dynamic flags, terraform init -backend-config="resource_group_name=XXXX" -backend-config="storage_account_name=XXXX" -backend-config="container_name=XXXX" --backend-config="key=XXXX"

For example:

```shell
terraform init --backend-config="resource_group_name=terraform_backend" --backend-config="storage_account_name=terraform-state-storage" --backend-config="container_name=hackathon-cluster" --backend-config="key=hackathon-cluster.tfstate"
```

Fill your terraform.tfvars file with the required data. Check with the variable file for the ones that are required, they have no defaults. The ones with defaults can be overridden by adding your required values within the tfvars file as well.
