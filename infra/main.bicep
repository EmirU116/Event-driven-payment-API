// targetScope = 'subscription'

// // parameters for the name of the resource group and location
// param resourceGroupName string = 'event-rg'
// param location string = 'westeurope'

// // Service Bus Parameters
// param serviceBusName string = 'sb-namespace'
// param serviceBusQueueName string = 'payment-queue'

// // Parameters for Key Vault
// param keyVaultName string = 'myKeyVaultDemo'
// param objectId string

// // Parameter for Cosmos DB
// param cosmosAccountName string = 'my-cosmos-account'
// param cosmosDBName string = 'auditlogdb'
// param cosmosContainerName string = 'transactions'

// @allowed([
//   'Basic'
//   'Standard'
//   'Premium'
// ])

// param skuName string = 'Basic'

// // calling resource script 
// module creatingRgModule 'resource.bicep' = {
//   name: 'createResourceGroup'
//   params: {
//     resourceGroupName: resourceGroupName
//     location: location
//   }
// }
// // creating function app from funcapp.bicep script with consumption plan
// module creatingfunctionapp 'FunctionApp/funcapp.bicep' = {
//   name: 'deployFuncApp'
//   scope: resourceGroup(resourceGroupName)   // <-- important
//   params: {
//     location: location
//     appNameSuffix: uniqueString(resourceGroupName)
//     functionAppName: 'myfunctionappgoklarz'
//   }
//   dependsOn: [
//     creatingRgModule
//   ]  
// } 
// // service bus (queue)
// module createServcieBus 'Service-Bus/service-bus.bicep' = {
//   name: 'deployServcieBus'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     serviceBusName: serviceBusName
//     servicebusQueueName: serviceBusQueueName
//     skuName: skuName
//     location: location
//   }
// }

// // Event Grid Topic creation
// module eventGridModuele 'Event-Grid-Topic/event-grid.bicep' = {
//   name: 'deployEventGridTopic'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     topicName: 'payment-event-grid'
//     location: location
//     inputSchemaNAme: 'EventGridSchema'
//   }
//   dependsOn: [
//     creatingRgModule
//   ]
// }

// // Cosmos DB Module
// module cosmosDBModule 'CosmosDB/cosmos.bicep' = {
//   name: 'cosmosDeployment'
//   scope: resourceGroup(resourceGroupName)
//   params: {
//     accountName: cosmosAccountName
//     containerName: cosmosContainerName
//     databaseName: cosmosDBName
//   }
// }
// // Access module outputs
// output cosmosContainerId string = cosmosDBModule.outputs.resourceId
// output cosmosContainerName string = cosmosDBModule.outputs.name

// // Key Vault
// module keyVaultModule 'KeyVault/keyvault.bicep' = {
//   scope: resourceGroup(resourceGroupName)
//   name: 'deployKeyVault'
//   params: {
//     keyvaulName: keyVaultName
//     objecId: objectId
//     location:location
//   }
// }




targetScope = 'subscription'

@description('Primary location for all resources')
param environmentName string

param location string
param appInsightsLocation string = ''
param resourceGroupName string = ''
param functionPlanName string = ''
param functionAppName string = ''
param storageAccountName string = ''
param logAnalyticsName string = ''
param applicationInsightsName string = ''
@allowed(['dotnet-isolated', 'python', 'java','node','powerShell'])
param functionAppRuntime string = 'dotnet-isolated'
@allowed(['3.10','3.11', '7.4', '8.0', '9.0', '10', '11', '17', '20', '21', '22'])
param functionAppRuntimeVersion string = '8.0'
@minValue(40)
@maxValue(1000)
param maximumInstanceCount int = 100
@allowed([512,2048,4096])
param instanceMemoryMB int = 2048
param zoneRedundant bool = false

param eventGridName string = 'deployEGrid'

param serviceBusNameNP string = 'deploySBNamespace'
param serviceBusNameTopic string = 'deploySBTopic'

// Generate a unique token to be used in naming resources.
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

var appName = !empty(functionAppName) ? functionAppName : '${resourceToken}'
// Generate a unique container name that will be used for deployments.
var deploymentStorageContainerName = 'app-package-${take(appName, 32)}-${take(resourceToken, 7)}'
var tags = {
  // Tag all resources with the environment name.
  'azd-env-name': environmentName
}

// Resource Group creation
resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${resourceGroupName}${environmentName}'
  location: location
  tags: tags
}

module storage 'storage/storage-account.bicep' = {
  name: 'storage'
  scope: rg
  params: {
    name: !empty(storageAccountName) ? storageAccountName : '${resourceToken}'
  }
}

module consumptionFunction 'FunctionApp/funcapp.bicep' = {
  name: 'functionapp'
  scope: rg
  params: {
    location: location
    tags: tags
    appName: appName
    applicationInsightsName: applicationInsightsName
    planName: !empty(functionPlanName) ? functionPlanName : '${resourceToken}' 
    functionAppRunTime: functionAppRuntime
    functionAppRunTimeVersion: functionAppRuntimeVersion
    maximumInstanceCount: maximumInstanceCount
    instanceMemory: instanceMemoryMB
    zoneRedundent: zoneRedundant
    deploymentStorageContainerName: deploymentStorageContainerName
    storageAccountName:storage.outputs.name
  }
}

module EventTopic 'Event-Grid-Topic/event-grid.bicep' = {
  scope: rg
  params: {
    topicName: eventGridName
    location: location
  }
}


module ServiceBusDeployment 'Service-Bus/service-bus.bicep' = {
  scope: rg
  params: {
    serviceBusName: serviceBusNameNP  
    servicebusQueueName: serviceBusNameTopic
  }
}
