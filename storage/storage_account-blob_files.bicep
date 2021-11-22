// The name of the Storage Account.
param storageAccountName string

// The location of the Storage Account.
param location string

// The access tier used for billing. Required for kind = BlobStorage.
@allowed([
  'Cool'
  'Hot'
])
param accessTier string

// Allow public access to all blobs or containers in the storage account.
param allowBlobPublicAccess bool

// Allow cross-AAD tenant object replication.
param allowCrossTenantReplication bool

// Allow requests to be authorized with a Shared Key instead of Azure AD.
param allowSharedKeyAccess bool

// Enables change feed event logging. HNS must be disabled.
param blobChangeFeedEnabled bool

// The number of days to retain the change feed, from 1 to 146000 or null for infinite retention.
param blobChangeFeedRetentionInDays int = 0

// The number of days to retain deleted containers, from 1 to 365.
@maxValue(365)
@minValue(1)
param blobContainerDeleteRetentionPolicyDays int

// Enables container soft delete.
param blobContainerDeleteRetentionPolicyEnabled bool

// The number of days to retain deleted blobs, from 1 to 365.
@maxValue(365)
@minValue(1)
param blobDeleteRetentionPolicyDays int

// Enables blob soft delete. Must opt-in per subscription if HNS is enabled.
param blobDeleteRetentionPolicyEnabled bool

// Enables versioning. HNS must be disabled.
param blobIsVersioningEnabled bool

// Enables last access time based tracking.
param blobLastAccessTimeTrackingPolicyEnabled bool

// The number of days blobs can be restored, from 0 to the delete retention policy days.
@minValue(0)
param blobRestorePolicyDays int

// Enables point-in-time restore, for block blobs only. HNS must be disabled.
param blobRestorePolicyEnabled bool

// Default authentication is OAuth.
param defaultToOAuthAuthentication bool

// The number of days to retain deleted file shares, from 1 to 365.
@maxValue(365)
@minValue(1)
param fileShareDeleteRetentionPolicyDays int

// Enables file share soft delete.
param fileShareDeleteRetentionPolicyEnabled bool

// Enables hierarchical namespace.
param hnsEnabled bool

// Enables account-level immutability. Auto-enabled Blob Versioning. HNS must be disabled.
param immutableStorageWithVersioning bool

// The type of the Storage Account.
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
param kind string

// Enables large file shares. Kind must be LRS or ZRS.
@allowed([
  'Disabled'
  'Enabled'
])
param largeFileSharesState string

// The minimum TLS version to be permitted on requests to storage.
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string

// Specifies whether traffic is bypassed.
@allowed([
  'AzureServices'
  'Logging'
  'Metrics'
  'None'
  'AzureServices, Logging'
  'AzureServices, Metrics'
  'AzureServices, Logging, Metrics'
  'Logging, Metrics'
])
param networkAclsBypass string

// The default action when no other rules match.
@allowed([
  'Allow'
  'Deny'
])
param networkAclsDefaultAction string

// Allows internet routing storage endpoints to be published.
param routingPreferencePublishInternetEndpoints bool

// Allows Microsoft routing storage endpoints to be published.
param routingPreferencePublishMicrosoftEndpoints bool

// The kind of network routing.
@allowed([
  'InternetRouting'
  'MicrosoftRouting'
])
param routingPreferenceRoutingChoice string

// Enables SFTP.
param sftpEnabled bool

// The name of the SKU.
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param skuName string

// Allows https traffic only.
param supportsHttpsTrafficOnly bool

// Immutable storage with versioning setting.
var immutableStorageWithVersioningSetting = {
  enabled: immutableStorageWithVersioning
}

// Formatted Storage Account name.
var storageAccountNameFormatted = toLower(storageAccountName)

// Create a Storage Account.
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountNameFormatted
  location: location
  kind: kind
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
    allowBlobPublicAccess: allowBlobPublicAccess
    allowCrossTenantReplication: allowCrossTenantReplication
    allowSharedKeyAccess: allowSharedKeyAccess
    defaultToOAuthAuthentication: defaultToOAuthAuthentication
    immutableStorageWithVersioning: immutableStorageWithVersioning ? immutableStorageWithVersioningSetting : json('null')
    isHnsEnabled: hnsEnabled
    isSftpEnabled: sftpEnabled
    largeFileSharesState: largeFileSharesState
    minimumTlsVersion: minimumTlsVersion
    networkAcls: {
      bypass: networkAclsBypass
      defaultAction: networkAclsDefaultAction
      ipRules: []
    }
    routingPreference: {
      publishInternetEndpoints: routingPreferencePublishInternetEndpoints
      publishMicrosoftEndpoints: routingPreferencePublishMicrosoftEndpoints
      routingChoice: routingPreferenceRoutingChoice
    }
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
  }
}

// Configure blob services.
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
    changeFeed: {
      enabled: blobChangeFeedEnabled
      retentionInDays: blobChangeFeedRetentionInDays == 0 ? json('null') : blobChangeFeedRetentionInDays
    }
    containerDeleteRetentionPolicy: {
      days: blobContainerDeleteRetentionPolicyDays
      enabled: blobContainerDeleteRetentionPolicyEnabled
    }
    deleteRetentionPolicy: {
      days: blobDeleteRetentionPolicyDays
      enabled: blobDeleteRetentionPolicyEnabled
    }
    isVersioningEnabled: blobIsVersioningEnabled
    lastAccessTimeTrackingPolicy: {
      enable: blobLastAccessTimeTrackingPolicyEnabled
    }
    restorePolicy: {
      days: blobRestorePolicyDays
      enabled: blobRestorePolicyEnabled
    }
  }
}

// Configure file services.
resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2021-06-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
    shareDeleteRetentionPolicy: {
      days: fileShareDeleteRetentionPolicyDays
      enabled: fileShareDeleteRetentionPolicyEnabled
    }
  }
}

output storageAccountName string = storageAccountNameFormatted
