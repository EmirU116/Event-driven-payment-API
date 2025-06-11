param name string
param location string = resourceGroup().location
param tags object = {
  
}

@allowed([
  'Cool'
  'Hot'
])
param accessTier string = 'Hot'
param allowBlobPublicAccess bool = false
param allowCrossTenantReplication bool = true
param allowSharedKeyAccess bool = false
param containers array = [
  
]
param defaultToOAuthAuthentication bool = false
param deleteRetentionPolicy object = {
  enabled: false 
}
@allowed([ 'AzureDnsZone', 'Standard'])
param dnsEndpointType string = 'Standard'
param kind string = 'StorageV2'
param minimumT1sVersion string = 'TLS1_2'
param networkAcls object = {
  bypass: 'AzureServices'
  defaultAction: 'Allow'
}
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Enabled'
param sku object = { name: 'Standard_LRS' }

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: name
  location: location
  sku: sku
  kind: kind
  properties: {
    accessTier: accessTier
    allowBlobPublicAccess: allowBlobPublicAccess
    allowCrossTenantReplication: allowCrossTenantReplication
    allowSharedKeyAccess: allowSharedKeyAccess
    defaultToOAuthAuthentication: defaultToOAuthAuthentication
    dnsEndpointType: dnsEndpointType
    minimumTlsVersion: minimumT1sVersion
    networkAcls: networkAcls
    publicNetworkAccess: publicNetworkAccess
  }
}


output name string = storage.name
output primaryEndpoints object = storage.properties.primaryEndpoints
output storageId string = storage.id
