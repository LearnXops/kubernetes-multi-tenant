#!/bin/bash

# Check if tenant name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <tenant-namespace>"
    echo "Example: $0 tenant1"
    exit 1
fi

TENANT=$1

# Delete all resources in the namespace
echo "Deleting all resources in namespace: $TENANT"
kubectl delete all --all -n $TENANT

# Delete the namespace
echo "Deleting namespace: $TENANT"
kubectl delete namespace $TENANT

echo "\nCleanup complete for tenant: $TENANT"
echo "\nVerifying resources:"
kubectl get namespaces | grep $TENANT || echo "Namespace $TENANT has been successfully deleted"
