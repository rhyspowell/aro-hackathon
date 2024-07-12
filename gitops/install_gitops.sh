passwd=`az aro list-credentials --name $CLUSTER --resource-group $RESOURCEGROUP --query "kubeadminPassword" -o tsv`
api_url=`az aro show --name $CLUSTER --resource-group $RESOURCEGROUP --query "apiserverProfile.url" -o tsv`

oc login $api_url --username kubeadmin --password $passwd
oc apply -f subscribe_gitops.yaml

az aro show --name $CLUSTER --resource-group $RESOURCEGROUP --query "consoleProfile.url" -o tsv