
// Storage parammeters / variables 

@description('Specifies region of all resources')
param location string = resourceGroup().location

@description('Suffix for function app, storage account, and key vault name')
param appNameSuffix string = uniqueString(resourceGroup().id)

@description('Storage account SKU name')
param storageSku string = 'Standard_LRS'

var storageAccountName = 'fnstor${replace(appNameSuffix, '-', '')}'
// Hosting Plan parameters / variables

@description('SKU for the hosting plan')
param hostingPlanSku string = 'Y1'


// Function App Parameters / Variables
@description('Name of the function app')
param functionAppName string

// Storage Account 
resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
// Hosting Plan (Consumption)

resource hostingPlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: '${functionAppName}-plan'
  location: location
  sku: {
    name: hostingPlanSku
    tier: 'Dynamic'
  }
  kind: 'function'
}
// Function App

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storage.name};AccountKey=${listKeys(storage.id, storage.apiVersion).keys[0].value};EndpointSuffix=core.windows.net'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTION_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
    httpsOnly: true
  }
  dependsOn: [
    storage
    hostingPlan
  ]
}
