targetScope = 'subscription'

// parameters for the name of the resource group and location
param resourceGroupName string = 'event-rg'
param location string = 'westeurope'

param serviceBusName string = 'sb-namespace'

param serviceBusQueueName string = 'payment-queue'


@allowed([
  'Basic'
  'Standard'
  'Premium'
])

param skuName string = 'Basic'

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

// Event Grid Topic creation
module eventGridModuele 'Event-Grid-Topic/event-grid.bicep' = {
  name: 'deployEventGridTopic'
  scope: resourceGroup(resourceGroupName)
  params: {
    topicName: 'payment-event-grid'
    location: location
    inputSchemaNAme: 'EventGridSchema'
  }
  dependsOn: [
    creatingRgModule
  ]
}

// Service Bus (Queue)
module serviceBusModule 'Service-Bus/service-bus.bicep' = 
{

}

// (optional) Monitor Logging
// Service Bus
// Connection with CI/CD
// Create an Cosmos Database & connect it
// Key Vault

