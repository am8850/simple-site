using './main.bicep'

param staticWebAppName = 'simple-site-swa'
param location = 'eastus2'
param skuName = 'Standard'
param frontDoorProfileName = 'simple-site-afd'
param frontDoorEndpointName = 'site'
param frontDoorOriginGroupName = 'static-web-app-origin-group'
param frontDoorOriginName = 'static-web-app-origin'
param frontDoorRouteName = 'default-route'
param frontDoorWafPolicyName = 'simple-site-waf'
param frontDoorSecurityPolicyName = 'default-security-policy'
param frontDoorWafMode = 'Prevention'
param tags = {
  environment: 'Standard'
  workload: 'simple-site'
}