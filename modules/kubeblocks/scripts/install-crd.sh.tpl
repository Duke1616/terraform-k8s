#!/bin/bash
kubectl apply -f ${crd_path}

if [ $? -eq 0 ]; then
    echo "Install CRD Success"
fi
