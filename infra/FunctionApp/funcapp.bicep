
// // Storage parammeters / variables 

// @description('Specifies region of all resources')
// param location string = resourceGroup().location

// @description('Suffix for function app, storage account, and key vault name')
// param appNameSuffix string = uniqueString(resourceGroup().id)

// @description('Storage account SKU name')
// param storageSku string = 'Standard_LRS'

// var storageAccountName = 'fnstor${replace(appNameSuffix, '-', '')}'
// // Hosting Plan parameters / variables

// @description('SKU for the hosting plan')
// param hostingPlanSku string = 'Y1'


// // Function App Parameters / Variables
// @description('Name of the function app')
// param functionAppName string

// resource storageAcc 'Microsoft.Storage/storageAccounts@2024-01-01' existing = {
//   name: storageAccountName
// }

// // Storage Account 
// resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
//   name: storageAccountName
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: storageSku
//   }
//   properties: {
//     supportsHttpsTrafficOnly: true
//     defaultToOAuthAuthentication: true
//     allowBlobPublicAccess: false
//   }
// }
// // Hosting Plan (Consumption)

// resource hostingPlan 'Microsoft.Web/serverfarms@2024-04-01' = {
//   name: '${functionAppName}-plan'
//   location: location
//   sku: {
//     name: hostingPlanSku
//     tier: 'Dynamic'
//   }
//   kind: 'function'
// }
// // Function App

// resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
//   name: functionAppName
//   location: location
//   kind: 'functionapp,linux'
//   properties: {
//     serverFarmId: hostingPlan.id
//     siteConfig: {
//       appSettings: [
//         {
//           name: 'AzureWebJobsStorage'
//           value: storageAcc.name
//         }
//         {
//           name: 'FUNCTIONS_EXTENSION_VERSION'
//           value: '~4'
//         }
//         {
//           name: 'FUNCTION_WORKER_RUNTIME'
//           value: 'dotnet-isolated'
//         }
//       ]
//     }
//     functionAppConfig: {
//       deployment: {
//         storage: {
//           type: 'blobContainer'
//           value: '${storage.properties.primaryEndpoints.blob}'
//           authentication: {
//             type: 'SystemAssignedIdentity'
//           }
//         }
//       }
//       runtime: {
//         name: 'dotnet-isolated'
//         version: '8.0'
//       }
//     }    
//   }
//   dependsOn: [
//     storage
//     hostingPlan
//   ]
// }


param planName string
param appName string
param location string = resourceGroup().location
param storageAccountName string
param deploymentStorageContainerName string
param applicationInsightsName string
param tags object = {}
param functionAppRunTime string = 'dotnet-isolated'
param functionAppRunTimeVersion string = '8.0'

param maximumInstanceCount int = 100
param instanceMemory int = 2048
param zoneRedundent bool = false

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' existing = {
  name: storageAccountName
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightsName
}

resource conFuncPlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: planName
  location: location
  tags: tags
  kind: 'functionapp'
  sku: {
    tier: 'Consumption'
    name: 'Y1'
  }
  properties: {
    zoneRedundant: zoneRedundent
  }
}

resource consumFuncApp 'Microsoft.Web/sites@2024-11-01' = {
  name: appName
  location: location
  tags: tags
  kind: 'functionapp, linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: conFuncPlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage__accountName'
          value: storage.name
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
      ]
    }
    functionAppConfig: {
      deployment: {
        storage: {
          type:'blobContainer'
          value:'${storage.properties.primaryEndpoints.blob}${deploymentStorageContainerName}'
          authentication: {
            type: 'SystemAssignedIdentity'
          }
        }
      }
      scaleAndConcurrency: {
        maximumInstanceCount: maximumInstanceCount
        instanceMemoryMB: instanceMemory
      }
      runtime: {
        name: functionAppRunTime
        version: functionAppRunTimeVersion
      }
    }
  }
}




