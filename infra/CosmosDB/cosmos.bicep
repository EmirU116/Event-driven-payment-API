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

// Create database resource
resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-12-01-preview' = {
    parent: account
    name: databaseName
    properties: {
        resource: {
            id: databaseName
        }
        options: {
            throughput: 1000
        }
    }
}

// Database container
resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-12-01-preview' = {
    parent: database
    name: containerName
    properties: {
        resource: {
            id: containerName
            partitionKey: {
                paths: [
                    '/myPartitionKey'
                ]
                kind: 'Hash'
            }
            indexingPolicy: {
                indexingMode: 'consistent'
                includedPaths: [
                 {
                    path: '/*'
                 }
                ]
                excludedPaths: [
                 {
                    path: '/_etag/?'
                 }
                ]
            }
        }
    }
}

output location string = location
output name string = container.name
output resourceGroupName string = resourceGroup().name
output resourceId string = container.id
