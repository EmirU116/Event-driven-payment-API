@description('Name of the service bus ')
param serviceBusName string
param skuName string = 'Basic'
param location string = resourceGroup().location

// Service Bus
resource serviceBus 'Microsoft.ServiceBus/namespaces/queues@2024-01-01' = {
  name: serviceBusName
  location: location
  sku: {
    name: skuName
  } 
}
