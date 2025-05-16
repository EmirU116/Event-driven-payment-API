targetScope = 'subscription'

param resourceGroupName string = 'event-rg'
param location string = 'westeurope'

module creatingRgModule 'resource.bicep' = {
  name: 'createResourceGroup'
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
}

