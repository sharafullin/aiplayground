az group create --name rg-tfstate --location germanywestcentral

az storage account create \
  --resource-group rg-tfstate \
  --name satfaiplayground \
  --sku Standard_LRS \
  --encryption-services blob

az storage container create \
  --name tfstate \
  --account-name satfaiplayground

az identity create \
  --name uai-github \
  --resource-group rg-tfstate