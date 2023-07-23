# Set the Azure context to the desired subscription
$SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"
Set-AzContext -SubscriptionId $SubscriptionId

# Step 3: Set Variables
$resourceGroupName = "motadataps1"
$namespaceName = "motadataeventhubnamespaceps1"
$eventHubName = "motadataeventhubps1"

# Step 4: Create the Event Hub inside the Event Hub Namespace
$eventHub = New-AzEventHub -ResourceGroupName $resourceGroupName -NamespaceName $namespaceName -Name $eventHubName

# Step 5: Get the RootManageSharedAccessKey Connection String for the Event Hub Namespace
$eventHubNamespace = Get-AzEventHubNamespace -ResourceGroupName $resourceGroupName -NamespaceName $namespaceName

$connectionString = $eventHubNamespace | Get-AzEventHubKey -KeyName "RootManageSharedAccessKey" | Select-Object -ExpandProperty PrimaryConnectionString

# Step 6: Print the Connection String
Write-Host "RootManageSharedAccessKey Connection String: $connectionString"