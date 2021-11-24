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

// Allow requests to be authorized with a Shared Key instead of Azure AD.
param allowSharedKeyAccess bool

// The type of the Storage Account.
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
param kind string

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
    allowSharedKeyAccess: allowSharedKeyAccess
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
