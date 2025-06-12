// Parameters
param location string = resourceGroup().location
param topicName string
param skuName string = 'Basic'
param inputSchemaName string = 'EventGridSchema'

// Event Grid Resource Deployment
resource eventGridTopic 'Microsoft.EventGrid/topics@2025-02-15' = {
  name: topicName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    inputSchema: inputSchemaName
  }
  sku:{
    name: skuName
  }
}


output topicId string = eventGridTopic.id
