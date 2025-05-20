// Parameters? 
param location string = resourceGroup().location
param topicName string = 'my-eventgrid-topic'

// Event Grid Resource Deployment
resource eventGridTopic 'Microsoft.EventGrid/topics@2025-02-15' = {
  name: topicName
  location: location
  sku:{
    name: 'Basic'
  }
  properties: {
    inputSchema: 'EventGridSchema'
  }
}
