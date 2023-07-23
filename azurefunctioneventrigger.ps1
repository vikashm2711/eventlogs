# Set the path to your local GitHub repository containing the Python files
$githubRepoPath = "https://raw.githubusercontent.com/vikashm2711/eventlogs/main/eventappfunctioncode/"

# Read the deployment parameters from the JSON file
$parametersFilePath = "C:\Path\To\Your\deploymentParameters.json"
$parameters = Get-Content $parametersFilePath | ConvertFrom-Json

# Authenticate with Azure
Connect-AzAccount

# Set the Azure context to the desired subscription
Set-AzContext -SubscriptionId $parameters.subscriptionId

# Create a new resource group if it doesn't exist
$resourceGroupName = $parameters.serverFarmResourceGroup
$location = $parameters.location
New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

# Create a new storage account
$storageAccountName = $parameters.storageAccountName
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -SkuName Standard_LRS -Location $location

# Create a new Function App
$functionAppName = $parameters.name
New-AzFunctionApp -ResourceGroupName $resourceGroupName -Name $functionAppName -StorageAccount $storageAccount -Location $location -AppServicePlan $parameters.hostingPlanName

# Deploy the Python files from the GitHub repository to the Function App
$functionApp = Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $functionAppName
$functionAppScmUri = $functionApp.ScmUri

# Copy inint.py, requiremnt.txt, and functions.json to Function App's wwwroot
$filesToCopy = @("__init__.py", "requiremnt.txt", "function.json")

foreach ($file in $filesToCopy) {
    $localFilePath = Join-Path $githubRepoPath $file
    $destinationPath = "site/wwwroot/$file"
    Invoke-AzResourceAction -ResourceGroupName $resourceGroupName -ResourceType Microsoft.Web/sites -ResourceName $functionAppName/default -Action sync -Parameters @{srcUrl = "$functionAppScmUri/$destinationPath"; dstUrl = "$functionAppScmUri/api/zip/$destinationPath"; "`$author"="ReplaceWithYourName"; "`$deployer"="powershell"; "`$message"="Updating $file"; "`$scmType"="VSTSRM"} -ApiVersion 2016-08-01 -Force
}

# Set the Linux FX version and App settings for the Function App
Set-AzWebApp -ResourceGroupName $resourceGroupName -Name $functionAppName -LinuxFxVersion $parameters.linuxFxVersion -NumberOfWorkers $parameters.numberOfWorkers -AppSettings @{"FUNCTIONS_WORKER_RUNTIME" = "python"}

# Add the Event Hub trigger to the Function App
$eventHubConnectionString = "ReplaceWithYourEventHubConnectionString" # Replace this with the actual connection string for your Event Hub
$eventHubName = "ReplaceWithYourEventHubName" # Replace this with the actual name of your Event Hub

$functionAppSettings = @{
    "EventHubConnectionString" = $eventHubConnectionString
    "EventHubName" = $eventHubName
}

Set-AzWebApp -ResourceGroupName $resourceGroupName -Name $functionAppName -AppSettings $functionAppSettings

# Verify the deployment and configuration
Write-Host "Azure Function App with Python Event Hub trigger has been deployed and configured."
