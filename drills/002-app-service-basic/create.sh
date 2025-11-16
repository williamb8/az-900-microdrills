#!/usr/bin/env bash
set -euo pipefail

# Deploy the Bicep template for this drill.
# TODO: set these vars before using.

RESOURCE_GROUP="${RESOURCE_GROUP:-az900-microdrills-rg}"
LOCATION="${LOCATION:-eastus}"
DEPLOYMENT_NAME="${DEPLOYMENT_NAME:-drill-deploy}"

echo "Using resource group: $RESOURCE_GROUP in $LOCATION"
echo "Creating resource group if it doesn't exist..."
az group create -n "$RESOURCE_GROUP" -l "$LOCATION"

echo "Deploying Bicep..."
az deployment group create \
  --name "$DEPLOYMENT_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --template-file infra.bicep

echo "✅ Deployment complete."
