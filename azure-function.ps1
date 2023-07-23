# Define variables for all the parameters in the deploymentParameters.json file
$subscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"
$name = "motadatafunctionappps1"
$location = "East US"
$use32BitWorkerProcess = $false
$ftpsState = "FtpsOnly"
$storageAccountName = "motadatastorageps1"
$linuxFxVersion = "Python|3.10"
$sku = "Dynamic"
$skuCode = "Y1"
$workerSize = "0"
$workerSizeId = "0"
$numberOfWorkers = "1"
$hostingPlanName = "ASP-motadataps1-996f"
$serverFarmResourceGroup = "motadataps1"
$alwaysOn = $false


# Set the Azure context to the desired subscription
$SubscriptionId = "5807cfb0-41a6-4da6-b920-71d934d4a2af"
Set-AzContext -SubscriptionId $SubscriptionId

# Deploy the Function App using the template with the defined parameters
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    # -TemplateFile $outputFilePath `
    -TemplateUri "https://raw.githubusercontent.com/vikashm2711/eventlogs/main/azure-function-template.json"
    -name $functionAppName `
    -location $location `
    -use32BitWorkerProcess $use32BitWorkerProcess `
    -ftpsState $ftpsState `
    -storageAccountName $storageAccountName `
    -linuxFxVersion $linuxFxVersion `
    -sku $sku `
    -skuCode $skuCode `
    -workerSize $workerSize `
    -workerSizeId $workerSizeId `
    -numberOfWorkers $numberOfWorkers `
    -hostingPlanName $hostingPlanName `
    -serverFarmResourceGroup $serverFarmResourceGroup `
    -alwaysOn $alwaysOn

Write-Host "Azure Function App '$functionAppName' created successfully in resource group '$resourceGroupName'."