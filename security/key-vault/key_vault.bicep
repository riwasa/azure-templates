// The name of the Key Vault.
param keyVaultName string

// The location of the resource.
param location string

// An array of 0 to 1024 identities that have access to the Key Vault.
param accessPolicies array = []

// Indicates whether Azure VMs are allowed to retrieve certificates stored as secrets.
param enabledForDeployment bool

// Indicates whether Azure Disk Encryption is allowed to retrieve secrets and unwrap keys.
param enabledForDiskEncryption bool

// Indicates whether Azure Resource Manager is allowed to retrieve secrets.
param enabledForTemplateDeployment bool

// Indicates whether protection against purge is enabled.
param enablePurgeProtection bool

// Indicates whether RBAC is used for authorization of data actions instead of Access Policies.
param enableRbacAuthorization bool

// Indicates whether soft delete is enabled.
param enableSoftDelete bool

// Specifies which traffic can bypass network rules.
@allowed([
  'AzureServices'
  'None'
])
param networkAclsBypass string

// The default action when no rule matches.
@allowed([
  'Allow'
  'Deny'
])
param networkAclsDefaultAction string

// The list of IP address rules.
param networkAclsIpRules array = []

// The list of Virtual Network rules.
param networkAclsVirtualNetworkRules array = []

// Indicates whether the vault accepts traffic from the public internet.
@allowed([
  'disabled'
  'enabled'
])
param publicNetworkAccess string

// The name of the SKU.
@allowed([
  'premium'
  'standard'
])
param skuName string

// The number of days to retain data if soft delete is enabled.
@maxValue(90)
@minValue(7)
param softDeleteRetentionInDays int

var isAccessPolicy = !empty(accessPolicies)

var addAccessPolicies = [for accessPolicy in accessPolicies: {
  objectId: accessPolicy.objectId
  permissions: accessPolicy.permissions
  tenantId: subscription().tenantId
}]

var isIpRules = !empty(networkAclsIpRules)

var addIpRules = [for ipRule in networkAclsIpRules: {
  value: ipRule.value
}]

var isVNetRules = !empty(networkAclsVirtualNetworkRules)

var addVNetRules = [for vnetRule in networkAclsVirtualNetworkRules: {
  id: vnetRule.id
  ignoreMissingVnetServiceEndpoint: vnetRule.ignoreMissingVnetServiceEndpoint
}]

// Create a Key Vault. empty(accessPolicies)
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    accessPolicies: isAccessPolicy ? addAccessPolicies : json('null')
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enablePurgeProtection: enablePurgeProtection ? enablePurgeProtection : json('null')
    enableRbacAuthorization: enableRbacAuthorization
    enableSoftDelete: enableSoftDelete
    networkAcls: {
      bypass: networkAclsBypass
      defaultAction: networkAclsDefaultAction
      ipRules: isIpRules ? addIpRules : json('null')
      virtualNetworkRules: isVNetRules ? addVNetRules : json('null')
    }
    publicNetworkAccess: publicNetworkAccess
    sku: {
      family: 'A'
      name: skuName
    }
    softDeleteRetentionInDays: enableSoftDelete ?softDeleteRetentionInDays : json('null')
    tenantId: subscription().tenantId
  }
}
