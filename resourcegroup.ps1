# Define your subscription ID
$SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"

# Set the Azure context to the desired subscription
Set-AzContext -SubscriptionId $SubscriptionId

# Set the name of the resource group where you want to deploy the Event Hub namespace
$resourceGroupName = "motadataps1"
$location = "eastus"

# Check if the resource group exists, create one if it doesn't
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    Write-Host "Resource group '$resourceGroupName' not found. Creating a new resource group..."
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}
else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}
