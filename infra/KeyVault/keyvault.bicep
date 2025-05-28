param keyvaulName string

param location string = resourceGroup().location

param tenantId string = subscription().tenantId

param objecId string


resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: keyvaulName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: tenantId
    accessPolicies: [
     {
      objectId: objecId     // The Object ID of a users, app, or managed identity
      permissions: {
        secrets: [      // Permissions being granted on secrets
          'get'       // Allows reading secrets values
          'list'      // Allows listing all secrets names ( not values )
          'set'       // Allows writing/updating secrets values
        ]
      }
      tenantId: tenantId  // The Azure AD tenant ID 
     }
    ]
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false
  }
}
