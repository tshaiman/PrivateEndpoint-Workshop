
echo "Part 1: Deploying VM and KeyVault"

# Variables
prefix="<Place Your Prefix Here>"

# create dummy ssh key and use it as password
ssh-keygen -t rsa -b 4096 -f ./id_rsa -q -N ""
publicSshKey=$(cat ./id_rsa.pub)
vaultName="${prefix}-kv"

rgName="${prefix}-rg"
location="eastus"

username=$(az account show  --query user.name -otsv)
userPrincipalId=$(az ad user show --id $username --query id -otsv)
echo "found userPrincipalId: $userPrincipalId"

echo "Creating Resource Group"
az group create --name $rgName --location $location

echo "deploy Bicep template"
az deployment group create \
  --name "bicep-deploy" \
  --resource-group $rgName \
  --template-file "./main.bicep" \
  --parameters \
    prefix=$prefix \
    userPrincipalId=$userPrincipalId \
    vaultName=$vaultName \
    vmAdminPasswordOrKey="$publicSshKey"

echo "Set simple Secret on the VM"
az keyvault secret set --vault-name $vaultName --name "secret" --value "12345678"