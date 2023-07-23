# Define the parameters for Event Hub namespace deployment
$namespaceName = "motadataeventhubnamespaceps1"
$location = "eastus"
$skuName = "Standard"
$skuTier = "Standard"
$skuCapacity = "1"
$isAutoInflateEnabled = "false"
$maximumThroughputUnits = "0"
$zoneRedundant = $true
$minimumTlsVersion = "1.2"
$disableLocalAuth = $false
$publicNetworkAccess = "Enabled"
$tags = @{}  # Empty tags as per the provided template

# Define your subscription ID
$SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"

# Set the Azure context to the desired subscription
Set-AzContext -SubscriptionId $SubscriptionId

# Set the name of the resource group where you want to deploy the Event Hub namespace
$resourceGroupName = "motadataps1"

# Create an empty array to store the JSON objects for each deployment
$jsonArray = @()



$paramObject = @{
        "parameters" = @{
            "name" = @{
                "type" = "String"
                "value" = "$namespaceName$i"
            }
            "location" = @{
                "type" = "String"
                "value" = $location
            }
            "skuName" = @{
                "type" = "String"
                "value" = $skuName
            }
            "skuTier" = @{
                "type" = "String"
                "value" = $skuTier
            }
            "skuCapacity" = @{
                "type" = "String"
                "value" = $skuCapacity
            }
            "isAutoInflateEnabled" = @{
                "type" = "String"
                "value" = $isAutoInflateEnabled
            }
            "maximumThroughputUnits" = @{
                "type" = "String"
                "value" = $maximumThroughputUnits
            }
            "zoneRedundant" = @{
                "type" = "Bool"
                "value" = $zoneRedundant
            }
            "minimumTlsVersion" = @{
                "type" = "String"
                "value" = $minimumTlsVersion
            }
            "disableLocalAuth" = @{
                "type" = "Bool"
                "value" = $disableLocalAuth
            }
            "publicNetworkAccess" = @{
                "type" = "String"
                "value" = $publicNetworkAccess
            }
            "tags" = @{
                "type" = "Object"
                "value" = $tags
            }
        }
        "contentVersion" = "1.0.0.0"
        "schema" = "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#"
    }

    # Add the parameter object to the array
    $jsonArray += $paramObject

# Convert the array to JSON string
$jsonString = $jsonArray | ConvertTo-Json

$TemplateParameterObject = $jsonString | ConvertFrom-Json

write $TemplateParameterObject

# Create the deployment command
$deploymentCommand = @{
    "Name" = "EventHubNamespaceDeployment"
    "ResourceGroupName" = $resourceGroupName
    "TemplateUri" = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
    "TemplateParameterObject" = $jsonString | ConvertFrom-Json
    "Verbose" = $true
}

New-AzResourceGroupDeployment @deploymentCommand

