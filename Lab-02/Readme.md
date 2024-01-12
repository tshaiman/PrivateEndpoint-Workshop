# Lab 02 - Protect PaaS Resource with Private Endpoint

## Description 
In previous Lab we have created a PaaS resource ( Azure Key Vault ) and accessed it from within a vnet.
In this lab we are going to create a Private Endpoint directing to our KV , configure Private DNS Zone 
and eventually Close the public accedss to the KV.

most of this lab will be performed from the Azure Portal .


## Steps:

1. Go to the network tab of the KV and select the Private Endpoint Tab.
2. Create new Private Endpoint pointing from your created VNET from Lab01 to the KV.
3. Accept the default setting when asked to create Private DNS Zone
4. Wait For the resources to be provisioned.

## Accessing the KV from within the Vnet

if you are still logged in using SSH to the VM , that is perfectly fine.
nothing is changed from the VM point of view and the DNS address we used before is also the same 

1. Run the following command both from your Laptop and from within the VNet . 

```sh
 nslookup <your_KV_NAME>.vault.azure.net
```

can you tell the difference ? 

2. Run the following command to retreive the value of the Secret created on step 1 : 

```sh
 az keyvault secret show --vault-name $vaultName --name "scecret"
```

notice that at this point the KV API is accessible from the public internet as well as from the VNEt using Private Endpoint

3. Close any Public Traffic to the KV using the Network tab on the Keyvault and repeat step 2.

**_NOTE_** at this stage you will be able to reteive the secret only from within the VM ( Vnet).

