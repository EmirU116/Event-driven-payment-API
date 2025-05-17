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

