@description('Name of the service bus ')
param serviceBusName string

param skuName string = 'Basic'

param location string = resourceGroup().location

@description('Name of the Queue')
param servicebusQueueName string

// Service Bus Namespace
resource serviceBus 'Microsoft.ServiceBus/namespaces@2024-01-01' = {
  name: serviceBusName
  location: location
  sku: {
    name: skuName
  }
  properties: {
    
  } 
}

resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2024-01-01' = {
  parent: serviceBus
  name: servicebusQueueName
  properties: {
    lockDuration:'PT2M'
  }
}
