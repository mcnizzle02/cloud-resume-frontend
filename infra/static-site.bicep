// =============================================================================
// Cloud Resume Challenge - frontend hosting on Azure Static Web Apps (Free)
//
// Replaces Azure Front Door + the Storage static website. The Free tier
// includes global hosting, HTTPS, and custom domains at no cost.
//
// Deploy:  az deployment group create -g rg-cloud-resume -f infra/static-site.bicep
// =============================================================================

@description('Static Web Apps only runs in a few regions. The site content is served globally either way.')
@allowed([
  'centralus'
  'eastus2'
  'westus2'
  'westeurope'
  'eastasia'
])
param location string = 'eastus2'

@description('Name of the Static Web App.')
param siteName string = 'swa-cloud-resume'

resource staticSite 'Microsoft.Web/staticSites@2023-12-01' = {
  name: siteName
  location: location
  tags: {
    project: 'cloud-resume'
    managedBy: 'bicep'
  }
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    // No repositoryUrl on purpose: we don't want Azure to connect to GitHub,
    // write its own workflow, and store a deployment token in the repo's
    // secrets. Our own pipeline deploys instead.
    allowConfigFileUpdates: true
    // No pull-request preview environments. On a public repo, they'd publish
    // anyone's proposed changes to a live URL.
    stagingEnvironmentPolicy: 'Disabled'
  }
}

output siteName string = staticSite.name
output defaultHostname string = staticSite.properties.defaultHostname
