targetScope='resourceGroup'

@description('Deployment location')
param location string = resourceGroup().location

@description('Deployment environment name, for example dev, test, prod')
param environment string

@description('Public IP address allowed to SSH, in CIDR format, for example 1.2.3.4/32')
param adminSourceIp string

var virtualNetworkName = 'vnet-iac-${environment}-weu'
var subnet1Name = 'snet-app'
var subnet2Name = 'snet-management'
var nsgName = 'nsg-workload-${environment}-weu'
var storageName = 'stiac${environment}weu001'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }

  resource appSubnet 'subnets' = {
    name: subnet1Name
    properties: {
      addressPrefix: '10.0.0.0/24'
      networkSecurityGroup: {
        id: nsg.id
      }
    }
  }

  resource managementSubnet 'subnets' = {
    name: subnet2Name
    properties: {
      addressPrefix: '10.0.1.0/24'
    }    
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgName
  location: location

  properties: {
    securityRules: [
      {
        name: 'AllowSSHFromMyIP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: adminSourceIp
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'DenySSHFromInternet'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Deny'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource storageAcct 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output virtualNetworkResourceId string = virtualNetwork.id
output appSubnetesourceId string = virtualNetwork::appSubnet.id
output managementSubnetResourceId string = virtualNetwork::managementSubnet.id
output storageAccountResourceId string = storageAcct.id
