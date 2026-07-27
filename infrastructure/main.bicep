@description('Name of the Azure Static Web App resource.')
param staticWebAppName string

@description('Azure region for the Static Web App resource.')
param location string = resourceGroup().location

@allowed([
  'Free'
  'Standard'
])
@description('SKU for the Azure Static Web App.')
param skuName string = 'Free'

@description('Optional tags to apply to the resource.')
param tags object = {}

resource staticWebApp 'Microsoft.Web/staticSites@2023-12-01' = {
  name: staticWebAppName
  location: location
  tags: tags
  sku: {
    name: skuName
    tier: skuName
  }
  properties: {}
}

output staticWebAppId string = staticWebApp.id
output staticWebAppNameOutput string = staticWebApp.name
output defaultHostname string = staticWebApp.properties.defaultHostname
