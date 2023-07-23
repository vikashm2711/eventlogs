# Parameters
$location = "eastus"           # Replace with your desired location
$name = "motadataeventhubnamespaceps1"     # Replace with your desired namespace name
$resourceGroupName = "motadataps1"   # Replace with your desired resource group name
$skuName = "Standard"            # Replace with your desired SKU name
$skuTier = "Standard"            # Replace with your desired SKU tier
$skuCapacity = "1"    # Replace with your desired SKU capacity
$isAutoInflateEnabled = $true         # Replace with your desired auto-inflate setting
$maximumThroughputUnits = "100"       # Replace with your desired maximum throughput units
$zoneRedundant = $false               # Replace with your desired zone redundancy setting
$minimumTlsVersion = "1.2"            # Replace with your desired minimum TLS version
$disableLocalAuth = $false            # Replace with your desired local auth setting
$publicNetworkAccess = "Enabled"      # Replace with your desired public network access setting

# Authenticate with Azure
# Connect-AzAccount
# Set the Azure context to the desired subscription
$SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"
Set-AzContext -SubscriptionId $SubscriptionId
# Create a new resource group if it doesn't exist
# New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

# Deploy the Event Hub namespace using the template with parameter values
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/vikashm2711/eventlogs/main/event-hub.json" `
    -name $name -location $location `
    -skuName $skuName -skuTier $skuTier -skuCapacity $skuCapacity `
    -isAutoInflateEnabled $isAutoInflateEnabled -maximumThroughputUnits $maximumThroughputUnits `
    -zoneRedundant $zoneRedundant -minimumTlsVersion $minimumTlsVersion `
    -disableLocalAuth $disableLocalAuth -publicNetworkAccess $publicNetworkAccess `
