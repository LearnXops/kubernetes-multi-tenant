#!/bin/bash

# Check if tenant name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <tenant-namespace>"
    echo "Example: $0 tenant1"
    exit 1
fi

TENANT=$1
MANIFEST_DIR="$(dirname "$0")/../manifests/$TENANT"

# Check if manifest directory exists
if [ ! -d "$MANIFEST_DIR" ]; then
    echo "Error: Manifest directory not found for tenant $TENANT"
    exit 1
fi

echo "Deploying tenant: $TENANT"
echo "Using manifests from: $MANIFEST_DIR"

# Apply all manifests in order
for file in "$MANIFEST_DIR"/*.yaml; do
    echo "Applying $file..."
    kubectl apply -f "$file"
done

echo "\nDeployment complete for tenant: $TENANT"
echo "\nVerifying resources:"
kubectl get all -n $TENANT
echo "\nResource usage:"
kubectl describe quota -n $TENANT

# Get the service URL if using a cloud provider
echo -e "\nAccess the application using:"
echo "kubectl port-forward svc/nginx-service 8080:80 -n $TENANT &"
echo "Then open: http://localhost:8080"
