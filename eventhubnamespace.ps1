# Parameters
$location = "YOUR_LOCATION"           # Replace with your desired location
$namespaceName = "YOUR_NAMESPACE"     # Replace with your desired namespace name
$resourceGroupName = "YOUR_RG_NAME"   # Replace with your desired resource group name
$skuName = "YOUR_SKU_NAME"            # Replace with your desired SKU name
$skuTier = "YOUR_SKU_TIER"            # Replace with your desired SKU tier
$skuCapacity = "YOUR_SKU_CAPACITY"    # Replace with your desired SKU capacity
$isAutoInflateEnabled = $true         # Replace with your desired auto-inflate setting
$maximumThroughputUnits = "100"       # Replace with your desired maximum throughput units
$zoneRedundant = $false               # Replace with your desired zone redundancy setting
$minimumTlsVersion = "1.2"            # Replace with your desired minimum TLS version
$disableLocalAuth = $false            # Replace with your desired local auth setting
$publicNetworkAccess = "Enabled"      # Replace with your desired public network access setting

# Authenticate with Azure
Connect-AzAccount

# Set the context to the desired subscription (if you have multiple subscriptions)
Set-AzContext -Subscription "YOUR_SUBSCRIPTION_ID"   # Replace with your subscription ID

# Create a new resource group if it doesn't exist
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

# Deploy the Event Hub namespace using the template with parameter values
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/vikashm2711/eventlogs/main/event-hub.json" `
    -namespaceName $namespaceName -location $location `
    -skuName $skuName -skuTier $skuTier -skuCapacity $skuCapacity `
    -isAutoInflateEnabled $isAutoInflateEnabled -maximumThroughputUnits $maximumThroughputUnits `
    -zoneRedundant $zoneRedundant -minimumTlsVersion $minimumTlsVersion `
    -disableLocalAuth $disableLocalAuth -publicNetworkAccess $publicNetworkAccess `
