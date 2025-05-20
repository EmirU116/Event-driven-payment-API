// Parameters? 
param location string = resourceGroup().location
param topicName string
//param skuName string = 'Basic'
param inputSchemaNAme string = 'EventGridSchema'



// Event Grid Resource Deployment
resource eventGridTopic 'Microsoft.EventGrid/topics@2025-02-15' = {
  name: topicName
  location: location
  properties: {
    inputSchema: inputSchemaNAme
  }
}
