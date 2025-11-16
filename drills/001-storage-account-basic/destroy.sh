#!/usr/bin/env bash
set -euo pipefail

# Option 1: delete specific resources (safer)
# Option 2: delete the whole resource group (more aggressive).

RESOURCE_GROUP="${RESOURCE_GROUP:-az900-microdrills-rg}"

read -rp "This will delete resource group '$RESOURCE_GROUP'. Continue? (y/N) " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "Cancelled."
  exit 0
fi

echo "Deleting resource group: $RESOURCE_GROUP..."
az group delete --name "$RESOURCE_GROUP" --yes --no-wait

echo "🧹 Destroy initiated. Resources will be removed."
