// The name of the Application Insights Component.
param applicationInsightsName string

// The name of the Log Analytics Workspace.
param logAnalyticsName string

// The location of the resources.
param location string

// The network access type for data ingestion.
@allowed([
  'Disabled'
  'Enabled'
])
param publicNetworkAccessForIngestion string

// The network access type for querying.
@allowed([
  'Disabled'
  'Enabled'
])
param publicNetworkAccessForQuery string

// Create a Log Analytics Workspace.
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Create an Application Insights Component.
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  dependsOn: [
    logAnalyticsWorkspace
  ]
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    Request_Source: 'rest'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
