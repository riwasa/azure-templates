// The name of the Log Analytics Workspace.
param workspaceName string

// The location of the resource.
param location string

// The maximum number of GB/day to ingest.
param dailyQuotaInGB int

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

// The number of days to retain data.
param retentionInDays int

// The name of the SKU.
@allowed([
  'CapacityReservation'
  'Free'
  'LACluster'
  'PerGB2018'
  'PerNode'
  'Premium'
  'Standalone'
  'Standard'
])
param skuName string

// Create a Log Analytics Workspace.
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  properties: {
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    retentionInDays: retentionInDays
    sku: {
      name: skuName
    }
    workspaceCapping: {
      dailyQuotaGb: dailyQuotaInGB
    }
  }
}
