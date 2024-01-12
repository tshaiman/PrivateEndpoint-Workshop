# Lab 01 - Create Resource with Public Access

## Description 
In this lab we are going to deploy the following resources :

- virtual network with 1 subnet
- Virtual Machine with System Assigned identity
- Network Interface Controller (Nic)
- NSG Rule 
- Azure Key Vault
- Role Assignment that grants your user and the Sytstem Assign Identity access to the Key Vault Secret Permission

The goal is to use this topology to learn how Private Endpoint works.

## Steps:

0. Ensure you are Az-Logged In to your Subscription : 

```
az login --used-device-code
az account set --subscription <Your_Subscription_ID>
```

or

```powershell
Connect-AzAccount -useDeviceAuthentication -subscriptionId <Your_Subscription_ID>
```

1. Open the lab Lab1 in Visual Studio Code .
2. Open deploy.sh ( or deploy.ps1) and add the following varaibles :

* Add Prefix on line 6 , e.g : _'myname'_
* Copy a public SSH Key from your ~/.ssh/id_rsa.pub into line 7

**_Note:_** It is Legal to copy Public SSH Key into scripts. this is how it is done in GitHub and Azure Dev Ops SSH Access.

3. Run the script by using the following command : 

```sh
chmod +x ./deploy.sh
./deploy.sh
```

or

```powershell
.\deploy.ps1
```

4. Head to Azure Portal and ensure the resource were deployed successfully.

## Understanding the connectivity to the KV

In Order to understand what is happening on the network level at this stage , we shall SSH into the vm 
and run the following command 

```sh
 nslookup <your_KV_NAME>.vault.azure.net
```

you can also try to retrieve the KV secret value 

```az
az keyvault secret show --vault-name $vaultName --name "scecret"
```

your should see the public IP Address of the KeyVault Service.

in the next section we shall protect this access with private endpoint
