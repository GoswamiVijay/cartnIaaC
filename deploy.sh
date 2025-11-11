#!/bin/bash

# Azure ARM Template Deployment Script
# This script deploys an ARM template to Azure using Azure CLI

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Parse command line arguments first (so help can be shown without Azure CLI)
TEMPLATE_FILE=""
PARAMETERS_FILE=""
RESOURCE_GROUP=""
DEPLOYMENT_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--template)
            TEMPLATE_FILE="$2"
            shift 2
            ;;
        -p|--parameters)
            PARAMETERS_FILE="$2"
            shift 2
            ;;
        -g|--resource-group)
            RESOURCE_GROUP="$2"
            shift 2
            ;;
        -n|--name)
            DEPLOYMENT_NAME="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 -t <template-file> -p <parameters-file> -g <resource-group> [-n <deployment-name>]"
            echo ""
            echo "Options:"
            echo "  -t, --template         Path to ARM template file (required)"
            echo "  -p, --parameters       Path to parameters file (required)"
            echo "  -g, --resource-group   Resource group name (required)"
            echo "  -n, --name            Deployment name (optional, auto-generated if not provided)"
            echo "  -h, --help            Show this help message"
            exit 0
            ;;
        *)
            print_message "$RED" "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    print_message "$RED" "Error: Azure CLI is not installed. Please install it from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if user is logged in
if ! az account show &> /dev/null; then
    print_message "$YELLOW" "You are not logged in to Azure. Please login..."
    az login
fi

# Validate required parameters
if [ -z "$TEMPLATE_FILE" ] || [ -z "$PARAMETERS_FILE" ] || [ -z "$RESOURCE_GROUP" ]; then
    print_message "$RED" "Error: Missing required parameters"
    echo "Use -h or --help for usage information"
    exit 1
fi

# Check if template file exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    print_message "$RED" "Error: Template file '$TEMPLATE_FILE' not found"
    exit 1
fi

# Check if parameters file exists
if [ ! -f "$PARAMETERS_FILE" ]; then
    print_message "$RED" "Error: Parameters file '$PARAMETERS_FILE' not found"
    exit 1
fi

# Generate deployment name if not provided
if [ -z "$DEPLOYMENT_NAME" ]; then
    DEPLOYMENT_NAME="deployment-$(date +%Y%m%d-%H%M%S)"
fi

print_message "$GREEN" "=== Azure ARM Template Deployment ==="
echo ""
print_message "$YELLOW" "Template File:    $TEMPLATE_FILE"
print_message "$YELLOW" "Parameters File:  $PARAMETERS_FILE"
print_message "$YELLOW" "Resource Group:   $RESOURCE_GROUP"
print_message "$YELLOW" "Deployment Name:  $DEPLOYMENT_NAME"
echo ""

# Validate the template
print_message "$GREEN" "Validating ARM template..."
if az deployment group validate \
    --resource-group "$RESOURCE_GROUP" \
    --template-file "$TEMPLATE_FILE" \
    --parameters "@$PARAMETERS_FILE" &> /dev/null; then
    print_message "$GREEN" "✓ Template validation successful"
else
    print_message "$RED" "✗ Template validation failed"
    az deployment group validate \
        --resource-group "$RESOURCE_GROUP" \
        --template-file "$TEMPLATE_FILE" \
        --parameters "@$PARAMETERS_FILE"
    exit 1
fi

# Deploy the template
print_message "$GREEN" "Deploying ARM template..."
if az deployment group create \
    --resource-group "$RESOURCE_GROUP" \
    --name "$DEPLOYMENT_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --parameters "@$PARAMETERS_FILE"; then
    print_message "$GREEN" "✓ Deployment completed successfully"
else
    print_message "$RED" "✗ Deployment failed"
    exit 1
fi

print_message "$GREEN" "=== Deployment Summary ==="
az deployment group show \
    --resource-group "$RESOURCE_GROUP" \
    --name "$DEPLOYMENT_NAME" \
    --query "{Status:properties.provisioningState, Timestamp:properties.timestamp}" \
    --output table
