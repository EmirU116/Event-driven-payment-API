targetScope = 'subscription'

// parameters for the name of the resource group and location
param resourceGroupName string = 'event-rg'
param location string = 'westeurope'

// calling resource script 
module creatingRgModule 'resource.bicep' = {
  name: 'createResourceGroup'
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
}
// creating function app from funcapp.bicep script with consumption plan
module creatingfunctionapp 'FunctionApp/funcapp.bicep' = {
  name: 'deployFuncApp'
  scope: resourceGroup(resourceGroupName)   // <-- important
  params: {
    location: location
    appNameSuffix: uniqueString(resourceGroupName)
    functionAppName: 'myfunctionappgoklarz'
  }
  dependsOn: [
    creatingRgModule
  ]  
} 
 
// (optional) Monitor Logging
// Service Bus
// Connection with CI/CD
// Create an Cosmos Database & connect it
// Event Grid
