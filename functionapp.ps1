# Parameters (Modify these with your desired values)
$resourceGroupName = "YourResourceGroupName"
$location = "East US"
$functionAppName = "motadatafunctionappps1"
$eventHubNamespaceName = "YourEventHubNamespaceName"
$eventHubName = "YourEventHubName"
$eventHubConnectionString = "YourEventHubConnectionString"

# Authenticate with Azure
Connect-AzAccount

# Set the context to the desired subscription (if you have multiple subscriptions)
Set-AzContext -Subscription "YourSubscriptionID"

# Create a new resource group if it doesn't exist
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

# Deploy the Function App with Python runtime
az deployment group create --resource-group $resourceGroupName --template-file "https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/function-app-template.json" `
                           --parameters sites_motadatafunctionapp2307_name=$functionAppName `
                                        serverfarms_ASP_motadata2307_996f_externalid="/subscriptions/5807cfb0-41a6-4da6-b920-71d934d4a2af/resourceGroups/motadata2307/providers/Microsoft.Web/serverfarms/ASP-motadata2307-996f"

# Configure the Event Hub trigger for the Function App
az functionapp eventhub trigger add --resource-group $resourceGroupName --name $functionAppName --event-hub-name $eventHubName --namespace-name $eventHubNamespaceName --connection-string $eventHubConnectionString
