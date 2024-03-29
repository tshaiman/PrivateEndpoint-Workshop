Write-Host "Part 1: Deploying VM and KV with MI !"

# Variables
$prefix="<Place Your Prefix Here>"

# create dummy ssh key and use it as password
ssh-keygen -t rsa -b 4096 -f ./id_rsa -q -N ""
$publicSshKey = Get-Content ./id_rsa.pub
$vaultName = "${prefix}-kv"

$rgName = "${prefix}-rg"
$location = "eastus"

$username = (az account show --query user.name -otsv)
$userPrincipalId = (az ad user show --id $username --query id -otsv)
Write-Host "found userPrincipalId: $userPrincipalId"

Write-Host "Creating Resource Group"
az group create --name $rgName --location $location

Write-Host "deploy Bicep template"
az deployment group create `
  --name "bicep-deploy" `
  --resource-group $rgName `
  --template-file "./main.bicep" `
  --parameters `
    prefix=$prefix `
    userPrincipalId=$userPrincipalId `
    vmAdminPasswordOrKey="$publicSshKey"

echo "Set simple Secret on the VM"
az keyvault secret set --vault-name $vaultName --name "secret" --value "12345678"