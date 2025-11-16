#!/usr/bin/env bash
set -euo pipefail

echo "📁 Creating base README..."
cat > README.md << 'EOF'
# AZ-900 Microdrills

Hands-on, repeatable AZ-900 practice drills.

## Structure

- `drills/001-storage-account-basic`  
- `drills/002-app-service-basic`  

Each drill includes:
- \`README.md\` – drill overview and steps
- \`infra.bicep\` – Azure infra template
- \`create.sh\` – deploy resources
- \`destroy.sh\` – tear down resources
- \`notes.md\` – your notes / gotchas
EOF

echo "📁 Creating folders..."
mkdir -p drills/001-storage-account-basic
mkdir -p drills/002-app-service-basic

create_drill_scaffold () {
  local DRILL_DIR="$1"

  echo "▶ Scaffolding $DRILL_DIR..."

  # README
  cat > "drills/${DRILL_DIR}/README.md" << 'EOF'
# Drill: <REPLACE WITH TITLE>

## Objective
- Replace this with the main goal for the drill.

## High-level steps
1. Review infra.bicep
2. Run `./create.sh`
3. Validate in Azure Portal
4. Capture notes in `notes.md`
5. Run `./destroy.sh`

## Success criteria
- Write what “done” looks like here.
EOF

  # infra.bicep
  cat > "drills/${DRILL_DIR}/infra.bicep" << 'EOF'
/*
  Skeleton Bicep file.
  Replace with real resources for this drill.
*/

targetScope = 'resourceGroup'

// Example:
// resource exampleStorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: 'replace-me'
//   location: resourceGroup().location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
// }
EOF

  # create.sh
  cat > "drills/${DRILL_DIR}/create.sh" << 'EOF'
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
EOF

  # destroy.sh
  cat > "drills/${DRILL_DIR}/destroy.sh" << 'EOF'
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
EOF

  # notes.md
  cat > "drills/${DRILL_DIR}/notes.md" << 'EOF'
# Notes

- Capture what broke, what you fixed, and what you learned.
- Treat this like your future interview cheat sheet.
EOF
}

create_drill_scaffold "001-storage-account-basic"
create_drill_scaffold "002-app-service-basic"

echo "🔧 Making scripts executable..."
chmod +x drills/001-storage-account-basic/create.sh
chmod +x drills/001-storage-account-basic/destroy.sh
chmod +x drills/002-app-service-basic/create.sh
chmod +x drills/002-app-service-basic/destroy.sh

echo "✅ Structure created."
echo "Next: 'git status' then commit and push."
