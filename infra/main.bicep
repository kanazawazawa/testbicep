// main.bicep

param location string = resourceGroup().location
param acrName string
param rgName string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

resource acr 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: acrName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrLoginServer string = acr.properties.loginServer
output acrAdminUsername string = listCredentials(acr.id, '2021-09-01').username
output acrAdminPassword string = listCredentials(acr.id, '2021-09-01').passwords[0].value
