Write-Host "Part 1: Deploying VM and KV with MI !"

# Variables
$prefix="<Place Your Prefix Here>"
$publicSshKey = "<Place Your Public SSH Key Here>"

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
az keyvault secret set --vault-name $vaultName --name "scecret" --value "12345678"