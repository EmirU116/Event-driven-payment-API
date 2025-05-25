@description('Cosmos DB account name')
param accountName string 

@description('Location for the Cosmos DB account')
param location string = resourceGroup().location

@description('The name for the SQL API database')
param databaseName string

@description('The name for hte SQL API container')
param containerName string

// Cosmos account resource (Free Tier)
resource account 'Microsoft.DocumentDB/databaseAccounts@2024-12-01-preview' = {
    name: toLower(accountName)
    location: location
    properties: {
        databaseAccountOfferType: 'Standard' 
        consistencyPolicy: {
            defaultConsistencyLevel: 'Session'
        }
        locations: [
            {
                locationName: location
            }
        ]
    }
}
