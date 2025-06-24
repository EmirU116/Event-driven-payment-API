targetScope = 'resourceGroup'

@description('Primary location for all resources')
param environmentName string = ''

param location string
param functionPlanName string = 'conplan-name-event'
param functionAppName string
param storageAccountName string
@allowed(['dotnet-isolated', 'python', 'java','node','powerShell'])
param functionAppRuntime string = 'dotnet-isolated'
@allowed(['3.10','3.11', '7.4', '8.0', '9.0', '10', '11', '17', '20', '21', '22'])
param functionAppRuntimeVersion string = '9.0'
param zoneRedundant bool = false



param eventGridName string = 'eg-deploy'

param serviceBusNameNP string  = 'sbn-deploy'
param serviceBusNameTopic string = 'sbnt-deploy'

var appName = functionAppName
var tags = {
  // Tag all resources with the environment name.
  'azd-env-name': environmentName
}

module storage 'storage/storage-account.bicep' = {
  name: 'myeventdrivenstorageaccount'
  scope: resourceGroup()
  params: {
    name: storageAccountName
  }
}

module consumptionFunction 'FunctionApp/funcapp.bicep' = {
  name: 'eventdrivenapiAppFuncDeploy'
  scope: resourceGroup()
  params: {
    location: location
    tags: tags
    appName: appName
    planName: functionPlanName

    // 🛠 These lines are now correctly named:
    functionAppRunTime: functionAppRuntime
    functionAppRunTimeVersion: functionAppRuntimeVersion
    zoneRedundant: zoneRedundant

    storageAccountName: storage.outputs.name
  }
}

module EventTopic 'Event-Grid-Topic/event-grid.bicep' = {
  name: 'deployeventgridtopic'
  scope: resourceGroup() 
  params: {
    topicName: eventGridName
    location: location
  }
}


module ServiceBusDeployment 'Service-Bus/service-bus.bicep' = {
  name: 'servicebusdeploy'
  scope: resourceGroup()
  params: {
    serviceBusName: serviceBusNameNP  
    servicebusQueueName: serviceBusNameTopic
    location: location
    skuName: 'Basic'
  }
}
