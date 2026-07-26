using './main.bicep'

param staticWebAppName = 'simple-site-swa'
param location = 'eastus2'
param skuName = 'Standard'
param tags = {
  environment: 'Standard'
  workload: 'simple-site'
}