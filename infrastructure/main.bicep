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

@description('Name of the Azure Front Door Standard profile.')
param frontDoorProfileName string = '${staticWebAppName}-afd'

@description('Name of the Azure Front Door endpoint.')
param frontDoorEndpointName string = 'site'

@description('Name of the Azure Front Door origin group.')
param frontDoorOriginGroupName string = 'static-web-app-origin-group'

@description('Name of the Azure Front Door origin.')
param frontDoorOriginName string = 'static-web-app-origin'

@description('Name of the Azure Front Door route.')
param frontDoorRouteName string = 'default-route'

@description('Name of the Front Door WAF policy.')
param frontDoorWafPolicyName string = '${staticWebAppName}-waf'

@description('Name of the Front Door security policy that associates WAF with the endpoint.')
param frontDoorSecurityPolicyName string = 'default-security-policy'

@allowed([
  'Detection'
  'Prevention'
])
@description('Operating mode for the Front Door WAF policy.')
param frontDoorWafMode string = 'Prevention'

@description('Optional tags to apply to the resources that support tags.')
param tags object = {}

var frontDoorSkuName = 'Standard_AzureFrontDoor'
var staticWebAppHostName = staticWebApp.properties.defaultHostname

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

resource frontDoorProfile 'Microsoft.Cdn/profiles@2024-02-01' = {
  name: frontDoorProfileName
  location: 'global'
  tags: tags
  sku: {
    name: frontDoorSkuName
  }
}

resource frontDoorEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2024-02-01' = {
  parent: frontDoorProfile
  name: frontDoorEndpointName
  location: 'global'
  properties: {
    enabledState: 'Enabled'
  }
}

resource frontDoorOriginGroup 'Microsoft.Cdn/profiles/originGroups@2024-02-01' = {
  parent: frontDoorProfile
  name: frontDoorOriginGroupName
  properties: {
    sessionAffinityState: 'Disabled'
    healthProbeSettings: {
      probeIntervalInSeconds: 120
      probePath: '/'
      probeProtocol: 'Https'
      probeRequestType: 'HEAD'
    }
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
  }
}

resource frontDoorOrigin 'Microsoft.Cdn/profiles/originGroups/origins@2024-02-01' = {
  parent: frontDoorOriginGroup
  name: frontDoorOriginName
  properties: {
    enabledState: 'Enabled'
    hostName: staticWebAppHostName
    httpPort: 80
    httpsPort: 443
    originHostHeader: staticWebAppHostName
    priority: 1
    weight: 1000
    enforceCertificateNameCheck: true
  }
}

resource frontDoorRoute 'Microsoft.Cdn/profiles/afdEndpoints/routes@2024-02-01' = {
  parent: frontDoorEndpoint
  name: frontDoorRouteName
  properties: {
    enabledState: 'Enabled'
    forwardingProtocol: 'HttpsOnly'
    httpsRedirect: 'Enabled'
    linkToDefaultDomain: 'Enabled'
    originGroup: {
      id: frontDoorOriginGroup.id
    }
    patternsToMatch: [
      '/*'
    ]
    supportedProtocols: [
      'Http'
      'Https'
    ]
  }
}

resource frontDoorWafPolicy 'Microsoft.Network/frontDoorWebApplicationFirewallPolicies@2023-09-01' = {
  name: frontDoorWafPolicyName
  location: 'global'
  tags: tags
  sku: {
    name: frontDoorSkuName
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: frontDoorWafMode
      requestBodyCheck: 'Enabled'
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'DefaultRuleSet'
          ruleSetVersion: '2.1'
        }
      ]
    }
  }
}

resource frontDoorSecurityPolicy 'Microsoft.Cdn/profiles/securityPolicies@2024-02-01' = {
  parent: frontDoorProfile
  name: frontDoorSecurityPolicyName
  properties: {
    parameters: {
      type: 'WebApplicationFirewall'
      wafPolicy: {
        id: frontDoorWafPolicy.id
      }
      associations: [
        {
          domains: [
            {
              id: frontDoorEndpoint.id
            }
          ]
          patternsToMatch: [
            '/*'
          ]
        }
      ]
    }
  }
}

output staticWebAppId string = staticWebApp.id
output staticWebAppNameOutput string = staticWebApp.name
output defaultHostname string = staticWebAppHostName
output frontDoorProfileId string = frontDoorProfile.id
output frontDoorProfileNameOutput string = frontDoorProfile.name
output frontDoorEndpointId string = frontDoorEndpoint.id
output frontDoorEndpointHostname string = frontDoorEndpoint.properties.hostName
output frontDoorWafPolicyId string = frontDoorWafPolicy.id
output frontDoorWafPolicyNameOutput string = frontDoorWafPolicy.name