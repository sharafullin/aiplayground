terraform -chdir=./aks init
terraform -chdir=./aks apply -auto-approve
acr_name=$(terraform -chdir=./aks output -raw acrname)

az acr login --name $acr_name

docker build --platform linux/amd64 -t $acr_name.azurecr.io/hello-aks:latest ./test-app
docker push $acr_name.azurecr.io/hello-aks:latest

az aks get-credentials --resource-group rg-aks --name aks-cluster

kubectl apply -f ./aks-app/