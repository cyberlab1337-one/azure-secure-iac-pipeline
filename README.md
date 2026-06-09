# Azure Secure IaC Pipeline

## Overview

This project demonstrates how to deploy Azure infrastructure using Infrastructure as Code (IaC) with Bicep and Azure DevOps Pipelines.

The solution includes automated validation and deployment of Azure resources using environment-specific parameter files for Development and Production environments.

## Technologies

* Microsoft Azure
* Bicep
* Azure DevOps Pipelines
* PowerShell
* Git

## Project Structure

* **main.bicep** – Defines Azure infrastructure resources.
* **parameters.dev.json** – Development environment configuration.
* **parameters.prod.json** – Production environment configuration.
* **azure-pipelines.yml** – CI/CD pipeline definition.
* **validate.ps1** – Infrastructure validation script.

## Resources

* VNet
2 subnets:
- app-subnet
- management-subnet

* NSG:
- allow SSH/RDP only from your IP
- deny unnecessary inbound traffic

* Storage Account
Log Analytics Workspace

## Learning Objectives

This project was created to practice:

* Azure Infrastructure as Code with Bicep
* CI/CD pipeline creation in Azure DevOps
* Infrastructure validation and deployment automation
* Git-based infrastructure management

## Deployment Flow

1. Source code is retrieved from the repository.
2. Infrastructure templates are validated.
3. Bicep templates are compiled and checked.
4. Azure resources are deployed using the selected parameter file.
5. Deployment results and logs are generated.
