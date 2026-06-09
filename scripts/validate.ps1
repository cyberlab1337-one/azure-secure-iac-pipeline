param(
    [string]$ResourceGroupName = "rg-iac-dev-weu",
    [string]$TemplateFile = "infra/main.bicep",
    [string]$ParametersFile = "infra/parameters.dev.json"
)

Write-Host "Building bicep file..."
az bicep build --file $TemplateFile

Write-Host "Validating deployment..."
az deployment group validate `
    --resource-group $ResourceGroupName `
    --template-file $TemplateFile `
    --parameters "@$ParametersFile" `
    --parameters adminSourceIp="$(curl -s ifconfig.me)/32"

Write-Host "Running what-if..."
az deployment group what-if `
    --resource-group $ResourceGroupName `
    --template-file $TemplateFile `
    --parameters "@$ParametersFile" `
    --parameters adminSourceIp="$(curl -s ifconfig.me)/32"