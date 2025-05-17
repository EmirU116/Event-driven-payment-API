
// Storage parammeters / variables 

@description('Specifies region of all resources')
param location string = resourceGroup().location

@description('Suffix for function app, storage account, and key vault name')
param appNameSuffix string = uniqueString(resourceGroup().id)

@description('Storage account SKU name')
param storageSku string = 'Standard_LRS'

var storageAccountName = 'fnstor${replace(appNameSuffix, '-', '')}'
// Hosting Plan parameters / variables

// Function App Parameters / Variables


// Storage Account 

// Hosting Plan (Consumption)

// Function App
